From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] mmc: sdhci-esdhc-imx: Remove the ENGcm07207 workaround
Date: Mon, 29 May 2017 16:42:23 +0200
Message-ID: <CAPDyKFo1Z-h_Ebr2FR4UvD_RuwfyOWGBk=6wc-GCRwdiqg-pnQ@mail.gmail.com>
References: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
 <1493805925-3644-4-git-send-email-benoit@wsystem.com> <b5c8c521-c2a7-89bf-8c36-519558079464@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34920 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdE2OmZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 May 2017 10:42:25 -0400
Received: by mail-qt0-f180.google.com with SMTP id v27so51225883qtg.2
        for <linux-mmc@vger.kernel.org>; Mon, 29 May 2017 07:42:24 -0700 (PDT)
In-Reply-To: <b5c8c521-c2a7-89bf-8c36-519558079464@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, joancarles <joancarles@fqingenieria.es>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>, Wolfram Sang <wsa@the-dreams.de>

On 29 May 2017 at 10:07, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 03/05/17 13:05, Beno=C3=AEt Th=C3=A9baudeau wrote:
>> The SDHCI_QUIRK_NO_MULTIBLOCK quirk was used as a workaround for the
>> ENGcm07207 erratum. However, it caused excruciatingly slow SD transfers
>> (300 kB/s on average), and this erratum actually does not imply that
>> multiple-block transfers are not supported, so this was overkill.
>>
>> The suggested workaround for this erratum is to set SYSCTL.RSTA, but the
>> simple DAT line software reset (which resets the DMA circuit among
>> others) triggered by sdhci_finish_data() in case of errors seems to be
>> sufficient. Indeed, generating errors in a controlled manner on i.MX25
>> using the FEVT register right in the middle of read data transfers
>> without this quirk shows that nothing is written to the buffer by the
>> eSDHC past CMD12, and no extra Auto CMD12 is sent with AC12EN set, so
>> the data transfers on AHB are properly aborted. For write data
>> transfers, neither extra data nor extra Auto CMD12 is sent, as expected.
>> Moreover, after intensive stress tests on i.MX25, removing
>> SDHCI_QUIRK_NO_MULTIBLOCK seems to be safe.
>>
>> Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>
>
> Aside from one comment below...
>
> I would expect to see Acks from other sdhci-esdhc-imx users.  Nevertheles=
s,
> for sdhci:

Yes, I would also appreciate some ack/tested by, from the
corresponding sdhci variant users of this series.

However, to allow it to get some results from linux-next, I have
queued up this series for next (amending $subject patch according to
the comment from Adrian). Thanks!

>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
>

[...]

Kind regards
Uffe
