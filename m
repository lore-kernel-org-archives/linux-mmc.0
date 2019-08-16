From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RFC PATCH 0/7] Add MMC packed function
Date: Fri, 16 Aug 2019 10:09:29 +0800
Message-ID: <CAMz4kuLNtHVzieJpD_etB3n4aa1sR3RiM6_KHLhC2QXCKGBzBA@mail.gmail.com>
References: <cover.1563782844.git.baolin.wang@linaro.org> <CAMz4ku+NjcqLY0tWRxrBCRUnkpyWih42LYieKaf0FO6WsqO2vA@mail.gmail.com>
 <8abff7d6-0a3e-efe7-e8ec-9309fada9121@intel.com> <CAMz4kuKri79CtVA=g7Mzoda_fQBYAEXDzL77RGw7g+e0F48jcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuKri79CtVA=g7Mzoda_fQBYAEXDzL77RGw7g+e0F48jcw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On Mon, 12 Aug 2019 at 17:44, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Hi Adrian,
>
> On Mon, 12 Aug 2019 at 16:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 12/08/19 8:20 AM, Baolin Wang wrote:
> > > Hi,
> > >
> > > On Mon, 22 Jul 2019 at 21:10, Baolin Wang <baolin.wang@linaro.org> wrote:
> > >>
> > >> Hi All,
> > >>
> > >> Now some SD/MMC controllers can support packed command or packed request,
> > >> that means it can package multiple requests to host controller to be handled
> > >> at one time, which can improve the I/O performence. Thus this patchset is
> > >> used to add the MMC packed function to support packed request or packed
> > >> command.
> > >>
> > >> In this patch set, I implemented the SD host ADMA3 transfer mode to support
> > >> packed request. The ADMA3 transfer mode can process a multi-block data transfer
> > >> by using a pair of command descriptor and ADMA2 descriptor. In future we can
> > >> easily expand the MMC packed function to support packed command.
> > >>
> > >> Below are some comparison data between packed request and non-packed request
> > >> with fio tool. The fio command I used is like below with changing the
> > >> '--rw' parameter and enabling the direct IO flag to measure the actual hardware
> > >> transfer speed.
> > >>
> > >> ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read
> > >>
> > >> My eMMC card working at HS400 Enhanced strobe mode:
> > >> [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> > >> [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> > >> [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> > >> [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> > >> [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
> > >>
> > >> 1. Non-packed request
> > >> I tested 3 times for each case and output a average speed.
> > >>
> > >> 1) Sequential read:
> > >> Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
> > >> Average speed: 28.7MiB/s
> >
> > This seems surprising low for a HS400ES card.  Do you know why that is?
>
> I've set the clock to 400M, but it seems the hardware did not output
> the corresponding clock. I will check my hardware.

I've checked my hardware and did not find any problem.

The reason of low speed is that I set the bs = 4k, when I changed the
bs=1M, and the speed can go up to 251MiB/s.

./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read
--bs=1M --size=512M --group_reporting --numjobs=20 --name=test_read
READ: bw=251MiB/s (263MB/s), 251MiB/s-251MiB/s (263MB/s-263MB/s),
io=10.0GiB (10.7GB), run=40826-40826msec

-- 
Baolin Wang
Best Regards
