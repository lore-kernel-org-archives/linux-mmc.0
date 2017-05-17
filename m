From: Stefan Agner <stefan@agner.ch>
Subject: Re: imx7: mmc_select_hs200 failed, error -74
Date: Wed, 17 May 2017 11:23:26 -0700
Message-ID: <a548e1627b3a18382958fc66a3829289@agner.ch>
References: <CAOMZO5ByTR1C4qUdc+hBcGTFVf-NH2gS5PmH3=w5-TrAoDQVUA@mail.gmail.com>
 <CAOMZO5AXb3-YGc7hGRP_OY8C-Go0pBECbDoQo1SUB1i=t1Xi4w@mail.gmail.com>
 <AM4PR0401MB232411A003DC9F9D2F9CAEA490E70@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <CAOMZO5BeE_Lm+VM8d9TKv0b21cL6dVNYgBai3wBjjm=bssXWCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:56528 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932139AbdEQSYJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 May 2017 14:24:09 -0400
In-Reply-To: <CAOMZO5BeE_Lm+VM8d9TKv0b21cL6dVNYgBai3wBjjm=bssXWCA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Bough Chen <haibo.chen@nxp.com>, "A.S. Dong" <aisheng.dong@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org

On 2017-05-17 11:02, Fabio Estevam wrote:
> Hi Haibo,
> 
> On Tue, May 16, 2017 at 11:10 PM, Bough Chen <haibo.chen@nxp.com> wrote:
> 
>> Hi Fabio,
>>
>> Can you open the mmc debug and show the full log?
>> By the way, you should first make sure whether the eMMC chip you used support HS200, and double
>> check whether the vccq voltage is 1.8v or 1.2v, HS200 mode can't work on 3.3v I/O voltage.
> 
> The imx7s warp board supplies 3.15V to VCCQ eMMC pins, so it cannot
> work in HS200 mode as you said.
> 
> In this case it should still be able to work in DDR52 mode though.

Maybe I missed something, but shouldn't that all be part of the device
tree these days?

E.g. mark that it is only 3.3V capable (no-1-8-v) and maybe other
capabilities (see Documentation/devicetree/bindings/mmc/mmc.txt).

> 
> Please see the patch I sent:
> http://marc.info/?l=linux-mmc&m=149495763808805&w=2

Afaict, the hardware tries to use whatever is the greatest common
denominator... If the board has restrictions, they should be specified
in the DT, and the driver should respect them.

--
Stefan
