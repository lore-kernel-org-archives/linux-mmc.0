Return-Path: <SRS0=IAZs=3R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22C4C33CB3
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 08:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B410124682
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 08:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dfbLU+6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgA1IIm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:08:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgA1IIl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2020 03:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Fu3XLdvdr0IP82rYkgFcpjUv0Mxvp/OR1gY+ZDGdVqM=; b=dfbLU+6xsIWrtOs6Oft/5Nz4rl
        4GhQ96YPPd/+WCWPfzjxryOhu4o2nBMynHYhi+iExb5SndS+xEnPu35mIqiblHZyA8ftLG7qMaJ01
        mIacK+l5KlpyWYFmkenj+92PNgY8Um1sYFKSxpDDSs4ss86oVKSAH/T8qoOKCWhGZhze03fu0Ig6L
        GTCyi/Vrg40gVv+26SePbmLjwCSMdHAHFNAOcZjIm+FFef7eOAeg7TJTHg+9Tzjjl4Y/rkw4mDTT2
        2REMyFqJkGWeHsdlVpD0ARVaAU4OmHFnbzJtJxIm1gg/Wo19sAkE4kzkURfjd9/G29BM9aV8kIguj
        RLXxvUkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwLvF-000473-UG; Tue, 28 Jan 2020 08:08:33 +0000
Date:   Tue, 28 Jan 2020 00:08:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Julian Margetson <runaway@candw.ms>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PASEMI PA6T PPC] Onboard CF card device with new SanDisk High
 (>8G) CF cards
Message-ID: <20200128080833.GA14099@infradead.org>
References: <20200108093903.57620-2-hdegoede@redhat.com>
 <61bc9265-ece0-eeb6-d4a1-4631138ecf29@intel.com>
 <8d67882d-04a8-0607-be4e-c1430b7fda21@redhat.com>
 <84a32714-ba08-74a0-0c76-3c36db44dd68@intel.com>
 <93446e09-5f12-800a-62fa-bf3ecea7273d@redhat.com>
 <399ac7d5-2518-799a-595e-f6b6878cf4ab@intel.com>
 <a9ab8946-c599-5f83-7527-2387a9e82e8a@xenosoft.de>
 <CAPDyKFoydOuSE=Eaq168=2_Ycouo7hzyw+RZXhGq7q4D4Qe8TQ@mail.gmail.com>
 <8736c5hyhr.fsf@mpe.ellerman.id.au>
 <688f1943-5b81-6200-d4d9-38d21b69e180@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <688f1943-5b81-6200-d4d9-38d21b69e180@xenosoft.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 28, 2020 at 08:58:29AM +0100, Christian Zigotzky wrote:
> Hi All,
> 
> Which mailing list is responsible for the pata_pcmcia driver? We are using
> new SanDisk High (>8G) CF cards with this driver [1] and we need the
> following line in the file "drivers/ata/pata_pcmcia.c".
> 
> +    PCMCIA_DEVICE_MANF_CARD(0x00f1, 0x0101),        /* SanDisk High (>8G)
> CFA */

Please send a formal patch for it to linux-ide@vger.kernel.org
