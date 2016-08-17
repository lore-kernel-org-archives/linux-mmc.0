From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [V2,
 10/15] mmc: sdhci-esdhc-imx: enable hw auto retuning for MAN_TUNING
Date: Wed, 17 Aug 2016 22:31:17 +0800
Message-ID: <CAA+hA=S=tpwykxqmV9MWJftrdM=RxR5QeLm+S=6Vx+zV3A2-vw@mail.gmail.com>
References: <1468309584-3591-11-git-send-email-aisheng.dong@nxp.com>
 <20160815145941.GA23663@t450s.lan> <20160816101818.GD9211@shlinux2>
 <20160816124444.GA31259@t450s.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160816124444.GA31259@t450s.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gary Bisson <gary.bisson@boundarydevices.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Haibo Chen <haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Gary,

On Tue, Aug 16, 2016 at 8:44 PM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:
> On Tue, Aug 16, 2016 at 06:18:18PM +0800, Dong Aisheng wrote:
>> On Mon, Aug 15, 2016 at 04:59:41PM +0200, Gary Bisson wrote:
>> > Dong Aisheng, All,
>> >
>> > On Tue, Jul 12, 2016 at 03:46:19PM +0800, Dong Aisheng wrote:
>> > > Indicating hw auto retuning support for mx6qdl in the fake caps_1
>> > > register and enable auto retuning in post_tuning process after
>> > > tuning completes.
>> >
>> > Have you tried this change with a SDIO3.0 device? I'm asking because a
>>
>> Tested with SD3.0 device.
>> Not really for SDIO3.0 device since there's no SDIO3.0 device on my
>> available MX6Q/DL boards.
>
> Someone answered on the Community that it has been tested on i.MX7 SABRE
> board but not on i.MX6 right?
>

Yes, we tested this feature with MX7 SDB board.
However, MX7 is slightly a bit different from MX6 that it's using STD_TUNING
rather than MAN_TUNING.

I just tried MAN_TUNING on MX7 which is the same as MX6, but i still
couldn't see your issue.

May try more and also on MX6 boards.

>> > similar change in latest NXP 4.1.15 kernel broke SDIO3.0 support.
>> > With this tuning, the kernel would report:
>> > mmc2: Got data interrupt 0x00000002 even though no data operation was in
>> > progress.
>> >
>>
>> Can you provide the full enumeration log?
>
> Here is the mmc related part of dmesg:
> # dmesg | grep mmc2
> mmc2: SDHCI controller on 2194000.usdhc [2194000.usdhc] using ADMA
> mmc2: queuing unknown CIS tuple 0x01 (3 bytes)
> mmc2: queuing unknown CIS tuple 0x1a (5 bytes)
> mmc2: queuing unknown CIS tuple 0x1b (8 bytes)
> mmc2: queuing unknown CIS tuple 0x14 (0 bytes)
> mmc2: queuing unknown CIS tuple 0x80 (1 bytes)
> mmc2: queuing unknown CIS tuple 0x81 (1 bytes)
> mmc2: queuing unknown CIS tuple 0x82 (1 bytes)
> mmc2: new ultra high speed SDR104 SDIO card at address 0001
> mmc2: queuing unknown CIS tuple 0x01 (3 bytes)
> mmc2: queuing unknown CIS tuple 0x1a (5 bytes)
> mmc2: queuing unknown CIS tuple 0x1b (8 bytes)
> mmc2: queuing unknown CIS tuple 0x14 (0 bytes)
> ar6k_wlan mmc2:0001:1: Direct firmware load for qsetup30.bin failed with
> error -2
> mmc2: Got data interrupt 0x00000002 even though no data operation was in
> progress.
> mmc2: Got data interrupt 0x00000002 even though no data operation was in
> progress.
>
> Without the MAN_TUN patch, everything is the same (as expected) but
> without the last two errors. Note that when WiFi connection is up, this
> warning keeps poping up every few seconds.
>

Could you please enable CONFIG_MMC_DEBUG and send out the full
card enumeration log?

>> > Doing a 'git bisect' and then reverting this patch fixed the issue.
>> > Although I haven't tested that change on mainline kernel, I wanted you
>> > to know about this observation before it gets merged.
>> >
>> > As a FYI, the issue has been reported to NXP community:
>> > https://community.nxp.com/thread/431316
>> >
>>
>> Thanks for nofity.
>> I will check it on my side.
>
> Not sure you've seen my last post from today, but you can actually try
> the device I'm using (QCA9377) on SABRE using the evaluation kit:
> http://www.silexamerica.com/products/connectivity-solutions/embedded-wireless/sdio-radios/sx-sdcac/
>

I do not have that WiFi card.
But i have a Broadcom SDIO3.0 WiFi card, i will find way to run it on MX6 board.

> Maybe there's a hw mod to do on SABRE in order to get SDIO3.0/1.8V vcc.
>

Did your card work on 1.8v IO voltage?
AFAIK usually the SDIO3.0 external WiFi card may not support 1.8v VIO and
needs special HW rework.

> Regards,
> Gary

Regards
Dong Aisheng
