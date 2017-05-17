From: Fabio Estevam <festevam@gmail.com>
Subject: Re: imx7: mmc_select_hs200 failed, error -74
Date: Wed, 17 May 2017 15:40:26 -0300
Message-ID: <CAOMZO5D8bixZD9TtBpCv5fOvBq=ArpWicKOno_9Dw6vPCgBXYg@mail.gmail.com>
References: <CAOMZO5ByTR1C4qUdc+hBcGTFVf-NH2gS5PmH3=w5-TrAoDQVUA@mail.gmail.com>
 <CAOMZO5AXb3-YGc7hGRP_OY8C-Go0pBECbDoQo1SUB1i=t1Xi4w@mail.gmail.com>
 <AM4PR0401MB232411A003DC9F9D2F9CAEA490E70@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <CAOMZO5BeE_Lm+VM8d9TKv0b21cL6dVNYgBai3wBjjm=bssXWCA@mail.gmail.com> <a548e1627b3a18382958fc66a3829289@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35733 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752968AbdEQSk1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 May 2017 14:40:27 -0400
Received: by mail-oi0-f47.google.com with SMTP id l18so26637035oig.2
        for <linux-mmc@vger.kernel.org>; Wed, 17 May 2017 11:40:27 -0700 (PDT)
In-Reply-To: <a548e1627b3a18382958fc66a3829289@agner.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Bough Chen <haibo.chen@nxp.com>, "A.S. Dong" <aisheng.dong@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Stefan,

On Wed, May 17, 2017 at 3:23 PM, Stefan Agner <stefan@agner.ch> wrote:

> E.g. mark that it is only 3.3V capable (no-1-8-v) and maybe other
> capabilities (see Documentation/devicetree/bindings/mmc/mmc.txt).

Passing 'no-1-8-v' to the dts did the trick, thanks!
