Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5C2C77B75
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Apr 2023 06:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjDRGQb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Apr 2023 02:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRGQa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Apr 2023 02:16:30 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25F95FC5;
        Mon, 17 Apr 2023 23:16:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4AD1B6431C28;
        Tue, 18 Apr 2023 08:16:26 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PbTqOREEgOBt; Tue, 18 Apr 2023 08:16:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 128896431C2D;
        Tue, 18 Apr 2023 08:16:25 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DIsehYAxzk58; Tue, 18 Apr 2023 08:16:24 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id DF7906431C28;
        Tue, 18 Apr 2023 08:16:24 +0200 (CEST)
Date:   Tue, 18 Apr 2023 08:16:24 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-renesas-soc <linux-renesas-soc@vger.kernel.org>,
        wsa+renesas <wsa+renesas@sang-engineering.com>,
        ulf hansson <ulf.hansson@linaro.org>
Message-ID: <971572458.117024.1681798584774.JavaMail.zimbra@nod.at>
In-Reply-To: <OS0PR01MB5922B8343E772A762315F764869D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <1674847756.113858.1681762124503.JavaMail.zimbra@nod.at> <OS0PR01MB5922B8343E772A762315F764869D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Subject: Re: Poor write performance to boot area using rcar-gen3-sdhi
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Poor write performance to boot area using rcar-gen3-sdhi
Thread-Index: jiFrfBZIr7HKS7MkHilHFl02Bun/Q/AMgGyAaB0PmjM=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Biju Das" <biju.das.jz@bp.renesas.com>
> Not sure, the file system used between /dev/mmcblk1boot1 and /dev/mmcblk1p13 is
> making
> difference at Linux?
> 
> I have seen performance difference between FAT and ext4.

There is no filesystem, I'm writing directly using dd
to the raw block device.

Thanks,
//richard
