From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Mon, 28 Nov 2016 12:09:33 +0100
Message-ID: <CAPDyKFp9rbGz=1PbAndKxvpv49H9DF5SWa=FfAcrMiYRceXOQA@mail.gmail.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA@mail.gmail.com>
 <3cd05a26-d340-476e-bab1-8be9d5446f47@marvell.com> <CAPDyKFrskyZvMwhmj8ioyaowU8GL5=d-6ipGQcmmig_a9E9AQQ@mail.gmail.com>
 <436c6925-cb0d-afe7-e3a2-384eca15ff42@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f181.google.com ([209.85.210.181]:35171 "EHLO
        mail-wj0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932875AbcK1LJg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2016 06:09:36 -0500
Received: by mail-wj0-f181.google.com with SMTP id v7so112476871wjy.2
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2016 03:09:35 -0800 (PST)
In-Reply-To: <436c6925-cb0d-afe7-e3a2-384eca15ff42@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziji Hu <huziji@marvell.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>

[...]

>
>     Could you please tell me the requirement of "op_code" parameter in
>     mmc_send_tuning()?
>     According to mmc_send_tuning(),it seems that tuning command(CMD19/CMD21)
>     is required. Thus device will not response mmc_send_tuning() if current
>     speed mode doesn't support tuning command.
>     Please correct me if I am wrong.
>

When the mmc core decides it's time to execute tuning, it invokes the
->execute_tuning() host ops, which has the "opcode" as a parameter.
You should be able to use it when calling mmc_send_tuning().

[...]

Kind regards
Uffe
