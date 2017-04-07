From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: IMX6 ESDHC mmc with UHS-I occasional failure with DDR50 cards
Date: Fri, 7 Apr 2017 12:55:28 -0700
Message-ID: <CAJ+vNU16hUhLufteFx2nqxnh1mrf6B025EqtpmWZp6USgfiJzw@mail.gmail.com>
References: <CAJ+vNU2S5NubFzKkHKjS2iHPt2_ysC-2e87ghUXPxsVEOKX+4w@mail.gmail.com>
 <20170404220040.GA2997@fen-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:35038 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932813AbdDGTzb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Apr 2017 15:55:31 -0400
Received: by mail-wr0-f176.google.com with SMTP id o21so87328901wrb.2
        for <linux-mmc@vger.kernel.org>; Fri, 07 Apr 2017 12:55:30 -0700 (PDT)
In-Reply-To: <20170404220040.GA2997@fen-net.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Haworth <dave@fen-net.de>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Weijun Yang <york.yang@csr.com>

On Tue, Apr 4, 2017 at 3:00 PM, David Haworth <dave@fen-net.de> wrote:
> Hi Tim,
>
> This looks uncomfortably familiar.
> I've been having problems with "some" micro-SDHC cards, but in
> different circumstances: mmc_spi on a raspberry pi.
>
> "Good" cards sign on as "mmcblk1: mmc1:0000 00000 7.35 GiB"
> "Bad" cards sign on as  "mmcblk1: mmc1:0000 SU08G 7.40 GiB"
> and eventually return a bit shifted response.
>
> The "bad" cards are all SanDisk cards. The "good" cards are cheap
> cards with one exception that is marked as SanDisk but looks like
> a fake.
>
> More details here:
> https://www.raspberrypi.org/forums/viewtopic.php?f=44&t=172562&p=1103943#p1103943
> if you can read it.
> Unfortunately I don't have a solution.
>
> All the best
> Dave
>

Dave,

Thanks for the response, but I don't think this is the same thing
because in your case I don't see any tuning or transfer errors
reported.

I've moved on to 4.11-rc5 and notice that I'm always seeing that on a
failure the imx sdhc not able to determine a min/max tuning delay:

4.11.0-rc5:
[   48.812381] mmc0: card aaaa removed
[   49.793392] mmc0: host does not support reading read-only switch,
assuming write-enable
[   49.810294] sdhci_execute_tuning
[   49.813612] esdhc_executing_tuning
[   49.968154] sdhci-esdhc-imx 2198000.usdhc: tuning failed at 0x7f
ret -5 (min=127/max=128)
^^^^ added debug shows -EIO returned from mmc_send_tuning although
I've also seen -84 get returned
[   49.980540] mmc0: tuning execution failed: -5
[   49.984974] mmc0: ddr50 tuning failed
[   49.989068] mmc0: new ultra high speed DDR50 SDHC card at address aaaa
[   49.999844] mmcblk0: mmc0:aaaa SL08G 7.40 GiB

I've also found that if I revert '9faac7b mmc: sdhci: enable tuning
for DDR50' thus skipping the tuning the issue goes away however note
that occasionally I do see a transfer error that perhaps is retried
[  361.067763] mmc0: card aaaa removed
[  361.412732] mmc0: host does not support reading read-only switch,
assuming write-enable
[  361.429719] mmc0: new ultra high speed DDR50 SDHC card at address aaaa
[  361.443060] mmcblk0: mmc0:aaaa SL08G 7.40 GiB
[  361.465658]  mmcblk0: p1
[  362.422335] mmc0: card aaaa removed
[  362.752719] mmc0: host does not support reading read-only switch,
assuming write-enable
[  362.769675] mmc0: new ultra high speed DDR50 SDHC card at address aaaa
[  362.782900] mmcblk0: mmc0:aaaa SL08G 7.40 GiB
[  362.805996] mmcblk0: error -84 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0xb00
^^^^ occasionally see this error but because retries occur at the
block level it still works
[  362.931689]  mmcblk0: p1

Again with 9faac7b reverted and some extra debugging:
[   33.823170] mmc0: host does not support reading read-only switch,
assuming write-enable
[   33.847185] mmc0: new ultra high speed DDR50 SDHC card at address aaaa
[   33.856063] mmcblk0: mmc0:aaaa SL08G 7.40 GiB
[   33.874227] mmcblk0: error -84 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0xb00
[   33.896829] mmcblk0: error -84 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0xb00
[   33.906312] mmcblk0: error -84 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0xb00
[   34.022117] mmcblk0: error 0 transferring data, sector 0, nr 8, cmd
response 0x900, card status 0xb00
^^^^ added debugging shows retries at block level and eventually all is fine
[   34.031500]  mmcblk0: p1

So far every DDR50 card I have (several Kingston and Sandisk card
models) behaves like this.

I tried adding a settling delay when VSELECT was changed in the
sdhci-esdhc-imx driver and that didn't help.

Tim
