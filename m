From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: SDHC Read Performance
Date: Mon, 21 Mar 2011 23:55:36 +0100
Message-ID: <201103212355.36951.arnd@arndb.de>
References: <20110119000909.GA9412@verge.net.au> <AANLkTi=fw1C0cj9U9=c0PxvOPHZtM66pDc+zpR9p=68c@mail.gmail.com> <20110321223809.GA27019@verge.net.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110321223809.GA27019@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

On Monday 21 March 2011 23:38:56 Simon Horman wrote:
> Write Speed
> # dd if=/dev/zero of=/dev/mmcblk0 bs=512 count=100000
> SD1.1:                  2.5 MB/s   <-- Faster than expected
> SD2.0:                  3.0 MB/s   <-- Faster than expected
> SDHC Class 2:           2.3 MB/s   <-- Faster than expected
> SDHC Class 10:          4.0 MB/s   <-- Slower than expected
> SanDisk SDHC Class 10:  4.3 MB/s   <-- Slower than expected
> MMC4.0:                 2.3 MB/s   <-- Clocked down to 12Mhz due to
>                                        driver limitations

Please see https://lwn.net/Articles/428584/ and https://wiki.linaro.org/WorkingGroups/KernelConsolidation/Projects/FlashCardSurvey
for possible explanations why your speed is not what you think
it should be.

I have written a tool that will give you more conclusive
data: git clone git://git.linaro.org/people/arnd/flashbench.git

Please Cc flashbench-results@lists.linaro.org when you have
measurements from that. You will first need to find out
the erase block size of each card (typically 4 MB), and then
pass that to the --open-au --erasesize=${SIZE} --open-au-nr=${NR}
benchmark to get useful results.

The write speed for writing full erase blocks (allocation units)
is normally the best that a card can provide, and you will see
how it gets worse with smaller block sizes. Try different
values for ${NR} to find out what the maximum is that the card
can sustain at full performance, most cards get really slow as
soon as it runs out of segments (not the case with your
benchmarking, since you write from start to end).

	Arnd
