From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCHv2 4/5] mmc: shdci-bcm2835: add verify for 32-bit back-to-back
 workaround
Date: Tue, 4 Nov 2014 21:26:46 -0800
Message-ID: <5459B516.30300@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com> <1414651017-3545-1-git-send-email-sbranden@broadcom.com> <1414651017-3545-5-git-send-email-sbranden@broadcom.com> <5459AB41.8080101@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:22037 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaKEF0s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Nov 2014 00:26:48 -0500
In-Reply-To: <5459AB41.8080101@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Griffin <peter.griffin@linaro.org>, Chris Ball <chris@printf.net>, Piotr Krol <pietrushnic@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, linux-rpi-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com

On 14-11-04 08:44 PM, Stephen Warren wrote:
> On 10/30/2014 12:36 AM, Scott Branden wrote:
>> Add a verify option to driver to print out an error message if a
>> potential back to back write could cause a clock domain issue.
>
>> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdh=
ci-bcm2835.c
>
>>   static inline void bcm2835_sdhci_writel(struct sdhci_host *host,
>>   						u32 val, int reg)
>>   {
>> +#ifdef CONFIG_MMC_SDHCI_BCM2835_VERIFY_WORKAROUND
>> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>> +	struct bcm2835_sdhci_host *bcm2835_host =3D pltfm_host->priv;
>> +
>> +	if (bcm2835_host->previous_reg =3D=3D reg) {
>> +		if ((reg !=3D SDHCI_HOST_CONTROL)
>> +			&& (reg !=3D SDHCI_CLOCK_CONTROL)) {
>> +			dev_err(mmc_dev(host->mmc),
>> +			"back-to-back write to 0x%x\n", reg);
>
> This fires a *ton* on reg 0x20 and 0x30 on my rev 2 model B with the
> patches applied on top of next-20141031. Without the patches applied,
> everything works fine. As far as I can tell, SD card accesses no long=
er
> work (or perhaps there's just so much log spew over serial that it ta=
kes
> more than 1.5 minutes to get to the login prompt).
>
Thanks for testing.  Like I said in the cover message - I've never run=20
this on a PI actually.  I've run it on other hardware with the same cor=
e=20
arasan block having the same clock domain issue.  The registers printed=
=20
out do not have the clock domain issue - I'm still getting more details=
=20
from the silicon designers on this.

Without the verify patch the performance is actually quite good.  See=20
tests result from Piotr:

On Fri, Oct 31, 2014 at 05:02:59PM +0000, Scott Branden wrote:
 > Please let me know how this works for you.
 >
Scott,
please ignore my previous mail I made mistake when applying patches.

Results of testing your code on top of 3.18-rc2 with Kingston SDC10/8GB=
:

* when compiling with CONFIG_MMC_SDHCI_BCM2835_VERIFY_WORKAROUND=3Dy th=
ere=20
is a
lot of:

sdhci-bcm2835 20300000.sdhci: back-to-back write to 0x30
and
sdhci-bcm2835 20300000.sdhci: back-to-back write to 0x20

* performance w/o patches:
yncraspberrypi:~$ sync; time dd if=3D/dev/zero of=3D~/test.tmp bs=3D500=
K=20
count=3D1024; sy
1024+0 records in
1024+0 records out
524288000 bytes (524 MB) copied, 787.384 s, 666 kB/s

real    13m7.404s
user    0m0.080s
sys     0m56.300s
pi@raspberrypi:~$ time dd if=3D~/test.tmp of=3D/dev/null bs=3D500K coun=
t=3D1024
1024+0 records in
1024+0 records out
524288000 bytes (524 MB) copied, 34.2115 s, 15.3 MB/s

real    0m34.232s
user    0m0.020s
sys     0m31.190s


* performance w/ patches is great IMHO:
yncraspberrypi:~$ sync; time dd if=3D/dev/zero of=3D~/test.tmp bs=3D500=
K=20
count=3D1024; sy
1024+0 records in
1024+0 records out
524288000 bytes (524 MB) copied, 45.4886 s, 11.5 MB/s

real    0m45.515s
user    0m0.060s
sys     0m30.050s time dd if=3D~/test.tmp of=3D/dev/null bs=3D500K coun=
t=3D1024
1024+0 records in
1024+0 records out
524288000 bytes (524 MB) copied, 33.6292 s, 15.6 MB/s

real    0m33.649s
user    0m0.020s
sys     0m30.730s

Great work!

Have you got plans to enable DMA for this controller ? sys CPU load is =
quite
big for above code, my tests with bcm2835-mmc and slave_sg from Raspber=
ryPi
=46oundation gives about 15s instead of 31s. It would be great to reliv=
e CPU a
little bit.

Best Regards,
Piotr Kr=F3l



