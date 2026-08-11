# NOTES

Where the handover pack does not say, I made a guess. Here they all are, plus what I left out.

## Assumptions

**About PR #482**

- I assumed it sits in the wallet service described in the reviewer notes: `wallet_txs` is a list of
  every money movement that is only ever added to, and the wallet balance should be the sum of that
  list. I could not see that table, so my review says the new ledger row is *missing things the
  existing rows have* — no key to stop a repeat, no link back to the payout row — instead of naming a
  column that does not match. If the real table needs more columns than the code writes, the insert
  fails outright, which only makes my point stronger.
- I do not know whether `bets.payout` can be empty for a bet that has not finished. So I asked it as a
  question on the PR rather than stating it. It matters because `SELECT 'NaN'::numeric` is valid in
  Postgres, so if the answer is yes, a broken balance can really be saved.
- The diff mounts `/admin` with no login check and there is none inside the router. If login is
  checked somewhere earlier that I cannot see, that comment drops from blocking to a question.
- I took "~40k members per brand" from the PR description and 30 brands from the scenario. That is
  about 1.2 million rows loaded by the unfiltered `Member.findAll()`.

**About the org and the plan**

- Week 10 for the region-4 launch is about day 70 of the 90, so the plan has roughly three weeks left
  after the launch.
- I assumed I can change what the two open roles ask for. If they are fixed at two mid-level backend
  engineers, both go to Payments, S.'s review load gets worse before it gets better, and the automatic
  checks become more urgent, not less.
- "Whoever notices, fixes" suggests there is no on-call rota, so setting one up is part of the
  incident process rather than something I inherit.
- I assumed there is a compliance or legal function to escalate to in C1, and that the call on
  telling the regulator is theirs to make using our facts.
- I assumed I can ship the automatic checks and database rules in the first two weeks without a long
  approval process. If not, that is the first thing I escalate.
- What the predecessor wrote about people (S. "makes juniors cry", L. "most experienced") is
  second-hand and two weeks old. I treat it as something to check in the first round of one-to-ones,
  not as fact. If S.'s reviews turn out to be fine and the juniors are simply not getting enough
  support, the coaching in Part A is wrong, but the pairing still stands.

## Left out on purpose

Budget and salaries, contract talks with providers, and how exactly the hiring process works beyond
noticing that 3 months empty is a signal. I also did not pick a specific technology for moving big
jobs out of web requests. All of that needs context the pack does not give, and making it up would
cost pages I would rather spend on decisions.

## On the limits

I measured these instead of guessing, because the brief says the limits are real. Printed on A4:
Part A is 3 pages, the Part B review is 1 page, and the answer is about half a page. C1 is 243 words
and C2 is 257, against the 300-word limit.

Two things changed once I printed it instead of trusting the word count. Part A came out at 4 pages
at first, which would have pushed the People section past where they stop reading, so I cut it and
turned the process table into a list — a three-column table with long cells eats far more height than
the same words as bullets. The Part B review came out at 2 pages, and moving it out of quote blocks
into plain paragraphs got the full line width back and brought it onto 1 page without dropping any
finding.

Writing it in plain English cost words rather than saving them. Explaining what a transaction is, or
why `FLOAT` is wrong for money, takes more space than the short technical version. I think that trade
is worth it, and it is why the cuts above were needed.
