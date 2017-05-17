From: Fabio Estevam <festevam@gmail.com>
Subject: Re: imx7: mmc_select_hs200 failed, error -74
Date: Wed, 17 May 2017 15:02:28 -0300
Message-ID: <CAOMZO5BeE_Lm+VM8d9TKv0b21cL6dVNYgBai3wBjjm=bssXWCA@mail.gmail.com>
References: <CAOMZO5ByTR1C4qUdc+hBcGTFVf-NH2gS5PmH3=w5-TrAoDQVUA@mail.gmail.com>
 <CAOMZO5AXb3-YGc7hGRP_OY8C-Go0pBECbDoQo1SUB1i=t1Xi4w@mail.gmail.com> <AM4PR0401MB232411A003DC9F9D2F9CAEA490E70@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33468 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754043AbdEQSCa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 May 2017 14:02:30 -0400
Received: by mail-oi0-f53.google.com with SMTP id w10so25457762oif.0
        for <linux-mmc@vger.kernel.org>; Wed, 17 May 2017 11:02:30 -0700 (PDT)
In-Reply-To: <AM4PR0401MB232411A003DC9F9D2F9CAEA490E70@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>
Cc: "A.S. Dong" <aisheng.dong@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stefan Agner <stefan@agner.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Haibo,

On Tue, May 16, 2017 at 11:10 PM, Bough Chen <haibo.chen@nxp.com> wrote:

> Hi Fabio,
>
> Can you open the mmc debug and show the full log?
> By the way, you should first make sure whether the eMMC chip you used support HS200, and double
> check whether the vccq voltage is 1.8v or 1.2v, HS200 mode can't work on 3.3v I/O voltage.

The imx7s warp board supplies 3.15V to VCCQ eMMC pins, so it cannot
work in HS200 mode as you said.

In this case it should still be able to work in DDR52 mode though.

Please see the patch I sent:
http://marc.info/?l=linux-mmc&m=149495763808805&w=2
