From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1] mmc: sdhci-of-esdhc: Workaround for reducing the
 maximum speed on ls1021atwr
Date: Sat, 23 Dec 2017 16:23:31 +0100
Message-ID: <CAPDyKFre8meCFORRQs3yT-u0er2Ht2w1x=2r=kJgsDSGZajv2w@mail.gmail.com>
References: <20171115090103.25366-1-yinbo.zhu@nxp.com> <CAPDyKFotZ9eZkSCj603BGuHOTCXitd7GmaKk0XFsj_7=CnoDgg@mail.gmail.com>
 <DB6PR0401MB253667427D21DFCAE486DD9BF8020@DB6PR0401MB2536.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:43407 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdLWPXd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Dec 2017 10:23:33 -0500
Received: by mail-it0-f66.google.com with SMTP id u62so17167276ita.2
        for <linux-mmc@vger.kernel.org>; Sat, 23 Dec 2017 07:23:32 -0800 (PST)
In-Reply-To: <DB6PR0401MB253667427D21DFCAE486DD9BF8020@DB6PR0401MB2536.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Y.b. Lu" <yangbo.lu@nxp.com>
Cc: Yinbo Zhu <yinbo.zhu@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 22 December 2017 at 09:13, Y.b. Lu <yangbo.lu@nxp.com> wrote:
> Hi Uffe,
>
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: 2017=E5=B9=B411=E6=9C=8816=E6=97=A5 15:34
>> To: Yinbo Zhu <yinbo.zhu@nxp.com>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>; Y.b. Lu <yangbo.lu@nxp.com>=
;
>> linux-mmc@vger.kernel.org
>> Subject: Re: [PATCH v1] mmc: sdhci-of-esdhc: Workaround for reducing the
>> maximum speed on ls1021atwr
>>
>> On 15 November 2017 at 10:01,  <yinbo.zhu@nxp.com> wrote:
>> > From: "yinbo.zhu" <yinbo.zhu@nxp.com>
>> >
>> > In SDHC high speed AC timing, the tshivkh parameter is defined as
>> > input setup times:SDHC_CMD, SDHC_DATx, to SDHC_CLK. The value of the
>> > tshivkh should be 2.5 ns considering the round trip delay, board/data
>> > skew.
>> > However, because of this erratum, it needs at least 4.1 ns.
>> >
>> > eSDHC cannot run at the maximum clock speed for the high speed mode,
>> > or there is a limit on the length of the trace on the board for data,
>> > command, and clock lines of the SDHC.
>> >
>> > Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
>> > ---
>> >  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
>> > b/drivers/mmc/host/sdhci-of-esdhc.c
>> > index 023c24bd0d94..2744dd58a573 100644
>> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
>> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>> > @@ -498,6 +498,12 @@ static void esdhc_of_set_clock(struct sdhci_host
>> *host, unsigned int clock)
>> >                         clock -=3D 5000000;
>> >         }
>> >
>> > +       /* Workaround to reduce the clock frequency for ls1021a esdhc =
*/
>> > +       if (of_find_compatible_node(NULL, NULL, "fsl,ls1021a-esdhc"))
>> > + {
>>
>> It's better to use the ->data pointer in the struct of_device_id for thi=
s kind of
>> variant data.
>>
>> In ->probe() you then call of_match_device() and pick up the ->data poin=
ter
>> and assign it to your driver private data.
>>
>> Many drivers already do like this. Have a look at dw_mmc-exynos.c for
>> example.
>>
>
> [Y.b. Lu] How about using soc_device_match()? There is also .data member =
could be used in soc_device_attribute structure.
> Use soc_device_match() in esdhc_init and get .data information into sdhci=
_esdhc structure which is private data.
> Current incorrect host version register value fix-up for some platforms i=
s using this method.

I think you need to answer the question: is the problem SoC specific
or device-variant specific. Depending on the answer, you should pick
the correct solution.

[...]

Kind regards
Uffe
