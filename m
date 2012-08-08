From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC/PATCH 0/2] ROW scheduling Algorithm
Date: Wed, 08 Aug 2012 16:27:36 +0900
Message-ID: <502214E8.7070603@samsung.com>
References: <1344166241-18708-1-git-send-email-tlinder@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-reply-to: <1344166241-18708-1-git-send-email-tlinder@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Tatyana Brokhman <tlinder@codeaurora.org>
Cc: axboe@kernel.dk, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi

I tested with this patch on my board.
But i didn't get any performance benefit.
Which benchmark did you use?
And sometime this scheduler didn't work well read/write operation.
(i didn't know exactly what problem.)

The below is my environment:
Kernel Version: linux-3.4
Card: eMMC4.5 (50MHz DDR mode, 8-bit buswidth)
Host controller : dw-mmc (DesignWare MMC controller)
Benchmark : IOzone

*CFQ Scheduler
Read : 35MB
Write : 17MB

*ROW Scheduler
Read : 28MB
Write : 17MB

How do you think about this result?

Best Regards,
Jaehoon Chung

On 08/05/2012 08:30 PM, Tatyana Brokhman wrote:
> The ROW scheduling algorithm will be used in mobile devices as defaul=
t
> block layer IO scheduling algorithm. ROW stands for "READ Over WRITE"
> which is the main requests dispatch policy of this algorithm.
>=20
> The ROW IO scheduler was developed with the mobile devices needs in
> mind. In mobile devices we favor user experience upon everything else=
,
> thus we want to give READ IO requests as much priority as possible.
> In mobile devices we won=E2=80=99t have AS much parallel threads as o=
n desktops.
> Usually it=E2=80=99s a single thread or at most 2 simultaneous workin=
g threads
> for read & write. Favoring READ requests over WRITEs decreases the RE=
AD
> latency greatly.
>=20
> The main idea of the ROW scheduling policy is:
> If there are READ requests in pipe - dispatch them but don't starve
> the WRITE requests too much.
>=20
> Bellow you=E2=80=99ll find a small comparison of ROW to existing sche=
dulers.
> The test that was run for these measurements is parallel lmdd read an=
d write.
> The tests were performed on:
> kernel version: 3.4
> Underline device driver: mmc
> Host controller: msm-sdcc
> Card:standard emmc NAND flash
>=20
> ---------------------------------------------------------------------=
-----
>    Algorithm   |   Throughput [mb/sec]   |   Worst case Latency [msec=
]   |
>                |     READ    |   WRITE   |     READ      |     WRITE =
    |
> ---------------------------------------------------------------------=
-----
> Noop           |    12.12    |   25.18   |     4407      |      4804 =
    |
> Deadline       |    12.02    |   24.6    |     705       |      5130 =
    |=20
> CFQ	       |    20.81    |   15.23   |     230       |      9370     =
|
> ROW	       |    27.75    |   15.34   |      85       |     12025     =
|
> ---------------------------------------------------------------------=
----|
>=20
>=20
> Tatyana Brokhman (2):
>   block: Expose kblock_schedule_delayed_work()
>   block: Adding ROW scheduling algorithm
>=20
>  Documentation/block/row-iosched.txt |  117 ++++++
>  block/Kconfig.iosched               |   22 ++
>  block/Makefile                      |    1 +
>  block/row-iosched.c                 |  675 +++++++++++++++++++++++++=
++++++++++
>  include/linux/blkdev.h              |    2 +
>  5 files changed, 817 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/block/row-iosched.txt
>  create mode 100644 block/row-iosched.c
>=20
