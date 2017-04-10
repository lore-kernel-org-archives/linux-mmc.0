From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v3, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
Date: Mon, 10 Apr 2017 12:48:30 +0200
Message-ID: <CAPDyKFpN-+7mxxeBHEELROWsn275Mec6unDHdnY3Gsz3oKT9pw@mail.gmail.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com> <DB6PR0401MB253627A0ABBF6DA9EC063A84F8010@DB6PR0401MB2536.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:33957 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbdDJKsb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Apr 2017 06:48:31 -0400
Received: by mail-ua0-f173.google.com with SMTP id u103so32228870uau.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Apr 2017 03:48:31 -0700 (PDT)
In-Reply-To: <DB6PR0401MB253627A0ABBF6DA9EC063A84F8010@DB6PR0401MB2536.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Y.B. Lu" <yangbo.lu@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Xiaobo Xie <xiaobo.xie@nxp.com>

On 10 April 2017 at 10:20, Y.B. Lu <yangbo.lu@nxp.com> wrote:
> Hi Andrian and Uffe,
>
> Do you have any comments on MMC patches?
> Could you help to merge the mmc patches if there is no changes requested?

I am waiting for Adrian's acks.

>
> Regarding to the dts patches, I have some more platforms to support.
> So I'd like to drop them currently, and send them all to arm mailing list for reviewing.

If it's new bindings/compatibles, the DT doc changes needs to be
discussed and agreed upon first. Actual changes to the DTS files,
should preferably go via the arm soc tree.

Kind regards
Uffe
