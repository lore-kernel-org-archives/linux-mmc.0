From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [RFC/PATCH 2/2] block: Adding ROW scheduling algorithm
Date: Wed, 19 Sep 2012 07:29:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1209190718030.29967@nerf07.vanv.qr>
References: <1344166241-18708-1-git-send-email-tlinder@codeaurora.org> <1344166241-18708-3-git-send-email-tlinder@codeaurora.org> <x49wr1cdlmg.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <x49wr1cdlmg.fsf@segfault.boston.devel.redhat.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Tatyana Brokhman <tlinder@codeaurora.org>, axboe@kernel.dk, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


On Monday 2012-08-06 18:35, Jeff Moyer wrote:
>Tatyana Brokhman writes:
>
>> This patch adds the implementation of a new scheduling algorithm - R=
OW.
>> The policy of this algorithm is to prioritize READ requests over WRI=
TE
>> as much as possible without starving the WRITE requests.
>
>Perhaps you could start off by describing the workload, and describing
>why the existing I/O schedulers do not perform well.

My setup is a 1=C2=A0GB RAM Atom N450 netbook, combined with the use of
dm-crypt for the 5400 rpm disk, which limits the effective write
throughput to somewhere around 20=E2=80=9326 MB/s. Now try this:

  ddrescue /dev/zero ~/bluntfile (or)

  (remote)# >nullfile
  (remote)# truncate -s 10G nullfile
  (local)# rsync -HPavz remote:nullfile .

The transfer rates of ddrescue/rsync first show 50=E2=80=9360 MB/s. Wai=
t
until writeout is forced - which is after ~700=E2=80=93800 MB in my cas=
e when
all buffers are full. The transfer rates then drop to the
aforementioned 20=E2=80=9326 MB/s.

In the so-loaded system, try to start an xterm (preferably by the use
of a shortcut, or starting one from another xterm). The wait time for
the shell prompt to appear is then the measure for interactivity,
with lower being better.

I have casually observed that ROW has 1/4th of the wait time in this
heavy disk write scenario (around 5=C2=A0s) for the shell to start up t=
han
with CFQ (20=E2=80=9321=C2=A0s). "Casual" meaning I had a clock with 1.=
0=C2=A0s
granularity beside me and ran this for like 3 times for each
scheduler, averaging it out.
