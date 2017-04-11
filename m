From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: IMX6 ESDHC mmc with UHS-I occasional failure with DDR50 cards
Date: Tue, 11 Apr 2017 07:21:39 -0700
Message-ID: <CAJ+vNU3gRG3K94V31EG1ufRsngsYG6hWq_97P2szZ2oATOd3=g@mail.gmail.com>
References: <CAJ+vNU2S5NubFzKkHKjS2iHPt2_ysC-2e87ghUXPxsVEOKX+4w@mail.gmail.com>
 <20170404220040.GA2997@fen-net.de> <CAJ+vNU16hUhLufteFx2nqxnh1mrf6B025EqtpmWZp6USgfiJzw@mail.gmail.com>
 <AM4PR0401MB23245B9B41978D09DAD9FD8D90000@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35908 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753753AbdDKOVl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Apr 2017 10:21:41 -0400
Received: by mail-wr0-f179.google.com with SMTP id c55so96392575wrc.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 Apr 2017 07:21:40 -0700 (PDT)
In-Reply-To: <AM4PR0401MB23245B9B41978D09DAD9FD8D90000@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>
Cc: David Haworth <dave@fen-net.de>, Linux MMC List <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Weijun Yang <york.yang@csr.com>, Adrian Hunter <adrian.hunter@intel.com>

On Tue, Apr 11, 2017 at 2:28 AM, Bough Chen <haibo.chen@nxp.com> wrote:
>> -----Original Message-----
<snip>
>>
>> I've moved on to 4.11-rc5 and notice that I'm always seeing that on a failure the
>> imx sdhc not able to determine a min/max tuning delay:
>>
>> 4.11.0-rc5:
>> [   48.812381] mmc0: card aaaa removed
>> [   49.793392] mmc0: host does not support reading read-only switch,
>> assuming write-enable
>> [   49.810294] sdhci_execute_tuning
>> [   49.813612] esdhc_executing_tuning
>> [   49.968154] sdhci-esdhc-imx 2198000.usdhc: tuning failed at 0x7f
>> ret -5 (min=127/max=128)
>> ^^^^ added debug shows -EIO returned from mmc_send_tuning although I've
>> also seen -84 get returned
>> [   49.980540] mmc0: tuning execution failed: -5
>> [   49.984974] mmc0: ddr50 tuning failed
>> [   49.989068] mmc0: new ultra high speed DDR50 SDHC card at address aaaa
>> [   49.999844] mmcblk0: mmc0:aaaa SL08G 7.40 GiB
>>
>> I've also found that if I revert '9faac7b mmc: sdhci: enable tuning for DDR50'
>> thus skipping the tuning the issue goes away however note that occasionally I
>> do see a transfer error that perhaps is retried [  361.067763] mmc0: card aaaa
>> removed [  361.412732] mmc0: host does not support reading read-only switch,
>> assuming write-enable [  361.429719] mmc0: new ultra high speed DDR50 SDHC
>> card at address aaaa [  361.443060] mmcblk0: mmc0:aaaa SL08G 7.40 GiB
>> [  361.465658]  mmcblk0: p1 [  362.422335] mmc0: card aaaa removed
>> [  362.752719] mmc0: host does not support reading read-only switch, assuming
>> write-enable [  362.769675] mmc0: new ultra high speed DDR50 SDHC card at
>> address aaaa [  362.782900] mmcblk0: mmc0:aaaa SL08G 7.40 GiB [  362.805996]
>> mmcblk0: error -84 transferring data, sector 0, nr 8, cmd response 0x900, card
>> status 0xb00 ^^^^ occasionally see this error but because retries occur at the
>> block level it still works [  362.931689]  mmcblk0: p1
>>
>> Again with 9faac7b reverted and some extra debugging:
>> [   33.823170] mmc0: host does not support reading read-only switch,
>> assuming write-enable
>> [   33.847185] mmc0: new ultra high speed DDR50 SDHC card at address aaaa
>> [   33.856063] mmcblk0: mmc0:aaaa SL08G 7.40 GiB
>> [   33.874227] mmcblk0: error -84 transferring data, sector 0, nr 8,
>> cmd response 0x900, card status 0xb00
>> [   33.896829] mmcblk0: error -84 transferring data, sector 0, nr 8,
>> cmd response 0x900, card status 0xb00
>> [   33.906312] mmcblk0: error -84 transferring data, sector 0, nr 8,
>> cmd response 0x900, card status 0xb00
>> [   34.022117] mmcblk0: error 0 transferring data, sector 0, nr 8, cmd
>> response 0x900, card status 0xb00
>> ^^^^ added debugging shows retries at block level and eventually all is fine
>> [   34.031500]  mmcblk0: p1
>>
>> So far every DDR50 card I have (several Kingston and Sandisk card
>> models) behaves like this.
>>
>> I tried adding a settling delay when VSELECT was changed in the sdhci-esdhc-
>> imx driver and that didn't help.
>>
> Hi Tim
>
> Which imx6 soc do you use?  From your log, I notice you use the MAN tuning method, so I guess you use imx6qdl.
>
> imx usdhc has an IC bug. For the tuning procedure, the first pass tuning delay value must bigger than 10.
> Due to DDR50 timing is not that rigorous, so maybe even when we just add 1 delay cell, tuning can pass, but this trigger the internal IC bug, then you meet the following issue just as you meet:
>        sdhci-esdhc-imx 2198000.usdhc: tuning failed at 0x7f        ( min=127/max=128)
>

Haibo,

Thanks for the response.

Yes, this issue is seen on the IMX6DQ and IMX6SDL. Can you point me to
information on this bug? I don't see it in the latest IMX6DQCE.pdf
errata document.

> So you can change the ESDHC_TUNE_CTRL_MIN from 0 to 15, then you can see the DDR50 tuning return to normal.
>
> For the STD tuning method, you can add the property 'fsl,tuning-start-tap = <20>' in dts.
>
> All this make the first trying tuning delay value larger than 10, to avoid  the internal IMX USDHC IC bug.
>
> SDR104 card do not has this issue, because for SDR104 card, the first pass tuning value normally larger than 10.
>

unfortunately, this does not resolve the issue. I tried
ESDHC_TUNE_CTRL_MIN of 15, 20, and 30 and they all produce the same
issue around 20% of insertions:
sdhci-esdhc-imx 2198000.usdhc: tunning failed at 0x7f ret -84

Here are some min/max tuning values from some various cards I have:
- Samsung SL08G DDR50: min=8 max=37
- Kingston SD8GB DDR50: min=8 max=36
- Sandisk SS16G DDR50: min=10 max=37
- Sandisk SU08G DDR50: min=9 max=36
- Samsung Pro 00000 SDR104: min=14 max=26
- Kingston SDR104 SDCIT: min=25 max=36

All of the DDR50 cards above fail in the same way appx 20% of insertions.

Has anyone else been able to confirm they see the same issue on IMX6
boards with UHS-I support and DDR50?

Regards,

Tim
