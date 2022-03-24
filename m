Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B959C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Mar 2022 11:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349719AbiCXLSl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Mar 2022 07:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349720AbiCXLSl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2022 07:18:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5523CA66D0
        for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2022 04:17:09 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nXLSe-0005xo-30; Thu, 24 Mar 2022 12:17:00 +0100
Message-ID: <ecc8cee6-e890-278e-2916-e7fd45276e6f@pengutronix.de>
Date:   Thu, 24 Mar 2022 12:16:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/4] dt-bindings: imx: add nvmem property
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, Peng Fan <peng.fan@nxp.com>,
        netdev@vger.kernel.org, s.hauer@pengutronix.de,
        linux-mmc@vger.kernel.org, qiangqing.zhang@nxp.com,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        robh+dt@kernel.org, mkl@pengutronix.de, linux-imx@nxp.com,
        kernel@pengutronix.de, kuba@kernel.org, krzk+dt@kernel.org,
        pabeni@redhat.com, shawnguo@kernel.org, davem@davemloft.net,
        wg@grandegger.com, festevam@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20220324042024.26813-1-peng.fan@oss.nxp.com>
 <20220324111104.cd7clpkzzedtcrja@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220324111104.cd7clpkzzedtcrja@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 24.03.22 12:11, Uwe Kleine-König wrote:
> I'd rather not have that in an official binding as the syntax is
> orthogonal to status = "..." but the semantic isn't. Also if we want
> something like that, I'd rather not want to adapt all bindings, but
> would like to see this being generic enough to be described in a single
> catch-all binding.

Cc += Srini who maintains the NVMEM bindings.

> I also wonder if it would be nicer to abstract that as something like:
> 
> 	/ {
> 		fuse-info {
> 			compatible = "otp-fuse-info";
> 
> 			flexcan {
> 				devices = <&flexcan1>, <&flexcan2>;
> 				nvmem-cells = <&flexcan_disabled>;
> 				nvmem-cell-names = "disabled";
> 			};
> 
> 			m7 {
> 				....
> 			};
> 		};
> 	};
> 
> as then the driver evaluating this wouldn't need to iterate over the
> whole dtb but just over this node. But I'd still keep this private to
> the bootloader and not describe it in the generic binding.

I like this, but being for bootloader consumption only doesn't mean that
this shouldn't be documented upstream. It's fine to have the binding,
even if Linux isn't expected to implement it.

Cheers,
Ahmad

> 
> Just my 0.02€
> Uwe


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
