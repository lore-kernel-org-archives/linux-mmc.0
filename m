From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 29 Jun 2011 21:44:58 +0530
Message-ID: <BANLkTiniSBRpgbW7cE0VritgCgstPbs5tg@mail.gmail.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-3-git-send-email-balajitk@ti.com>
	<alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com>
	<BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com>
	<alpine.DEB.2.00.1106281240390.2874@utopia.booyaka.com>
	<BANLkTikni_xO7NQXQyv7XVeEH4Nowpr1Ow@mail.gmail.com>
	<alpine.DEB.2.00.1106290841160.2874@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1106290841160.2874@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 29, 2011 at 8:12 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 29 Jun 2011, T Krishnamoorthy, Balaji wrote:
>
>> On Wed, Jun 29, 2011 at 12:11 AM, Paul Walmsley <paul@pwsan.com> wro=
te:
>> > On Tue, 28 Jun 2011, T Krishnamoorthy, Balaji wrote:
>> >
>> >> On Tue, Jun 28, 2011 at 10:52 PM, Paul Walmsley <paul@pwsan.com> =
wrote:
>> >> >
>> >> > On Wed, 22 Jun 2011, Balaji T K wrote:
>> >> >
>> >> >> Use runtime autosuspend APIs to enable auto suspend delay
>> >> >
>> >> > Does this really need to use runtime autosuspend? =A0Seems to m=
e that since
>> >> > PM runtime is just controlling the MMC IP blocks and not the re=
gulators in
>> >> > this instance, this could simply use pm_runtime_put*() and just=
 avoid the
>> >> > extra power wastage and complexity involved in autosuspend.
>> >>
>> >> I have seen some instabilities if delay is very less, on some pro=
duction boards.
>> >
>> > Could you be more specific? =A0What type of instabilities did you =
see?
>>
>> There have been some experiments on our customer programs to reduce =
this
>> value to a few ms and infrequent crashes were observed (stress testi=
ng
>> for several hours) while trying to access the controller registers.
>
> Was there an oops? =A0Any analysis, etc.?

OOPS pointed to omap_hsmmc_prepare_data / set_data_timeout
Use case was MMC + SDIO +GPS activity, on kernel 2.6.35 though.

Unhandled fault: imprecise external abort (0x1406) at 0x4073102c
Internal error: : 1406 [#1] PREEMPT SMP
last sysfs file: /sys/devices/platform/switch-sio/usb_sel
Modules linked in: param(P) j4fs(P) vibetonz Si4709_driver fm_drv(C)
bt_drv(C) st_drv(C)
CPU: 0    Tainted: P        WC   (2.6.35.7 #2)
PC is at clk_get_rate+0x4/0x48
LR is at set_data_timeout+0x68/0xf4
[<c06e78e0>] (set_data_timeout+0x0/0xf4) from [<c06e7dc8>]
(omap_hsmmc_request+0x2d0/0x5c8)
 r8:efa78400 r7:00000001 r6:00000000 r5:ef9efe78 r4:efa78640
r3:ef9efee4
[<c06e7af8>] (omap_hsmmc_request+0x0/0x5c8) from [<c06df040>]
(mmc_wait_for_req+0x118/0x130)
[<c06def28>] (mmc_wait_for_req+0x0/0x130) from [<c06e59e8>]
(mmc_blk_issue_rq+0x1c0/0x500)
 r6:ef86f000 r5:efa79000 r4:c91e61a0
[<c06e5828>] (mmc_blk_issue_rq+0x0/0x500) from [<c06e6620>]
(mmc_queue_thread+0xf4/0xf8)
[<c06e652c>] (mmc_queue_thread+0x0/0xf8) from [<c045ddec>] (kthread+0x8=
4/0x8c)
[<c045dd68>] (kthread+0x0/0x8c) from [<c044b748>] (do_exit+0x0/0x604)
 r7:00000013 r6:c044b748 r5:c045dd68 r4:ef8d5d68
Code: e1a00004 e89da8f0 c0a653c0 e1a0c00d (e92dd818)
---[ end trace 533b4c955f5abafd ]---

>
>
> - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
