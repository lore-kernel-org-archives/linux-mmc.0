Return-Path: <SRS0=IAZs=3R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA2FC33CB3
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 08:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788142465B
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 08:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="DRNYann7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgA1IBd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:01:33 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:15043 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgA1IBd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2020 03:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580198491;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=QV6nYKZBIO4WI3rfmuSOXDfWplBLhb0C0CHbzIiwZ5Q=;
        b=DRNYann7fVC9uJ7HzS3hgAxdw4ry7kOpLoDYwKO5dZtB9e3rAWy8jXJ0MNbyeDBXT7
        Y8Lm/A7+TNvcJdmwpK1RmcruJJ2Q/0yMcJH67WBHTpsfv+Ov9CtSIc2MlDyO2RSkpYew
        MdgdC7nAqkcmNdAiI9D79hqPpVqqBlgrnjcbhWQZ4dIWghONg+Ede4ZSMSxbHxii/87F
        PRvXaZXBlBNrSjsfAL5Ak/P4UgYWPqy6KqILYa8kzxGDdfwfEhq76EDT7iLZUiosKL7u
        xkVtexlMehZbM4S0NXijDLeEHVfzhtG6/sIWxsyVZ/dlxnV88GexA+GPOj4D/NcsR+hU
        5XZg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhQIm3EseWh4IuTiRKK0dhKoJuKag=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:34b8:6e34:7a4d:c0db]
        by smtp.strato.de (RZmta 46.1.7 AUTH)
        with ESMTPSA id k0b198w0S7wULJ0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 28 Jan 2020 08:58:30 +0100 (CET)
Subject: [PASEMI PA6T PPC] Onboard CF card device with new SanDisk High (>8G)
 CF cards
To:     Michael Ellerman <mpe@ellerman.id.au>,
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
References: <20200108093903.57620-1-hdegoede@redhat.com>
 <20200108093903.57620-2-hdegoede@redhat.com>
 <61bc9265-ece0-eeb6-d4a1-4631138ecf29@intel.com>
 <8d67882d-04a8-0607-be4e-c1430b7fda21@redhat.com>
 <84a32714-ba08-74a0-0c76-3c36db44dd68@intel.com>
 <93446e09-5f12-800a-62fa-bf3ecea7273d@redhat.com>
 <399ac7d5-2518-799a-595e-f6b6878cf4ab@intel.com>
 <a9ab8946-c599-5f83-7527-2387a9e82e8a@xenosoft.de>
 <CAPDyKFoydOuSE=Eaq168=2_Ycouo7hzyw+RZXhGq7q4D4Qe8TQ@mail.gmail.com>
 <8736c5hyhr.fsf@mpe.ellerman.id.au>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <688f1943-5b81-6200-d4d9-38d21b69e180@xenosoft.de>
Date:   Tue, 28 Jan 2020 08:58:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8736c5hyhr.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi All,

Which mailing list is responsible for the pata_pcmcia driver? We are 
using new SanDisk High (>8G) CF cards with this driver [1] and we need 
the following line in the file "drivers/ata/pata_pcmcia.c".

+    PCMCIA_DEVICE_MANF_CARD(0x00f1, 0x0101),        /* SanDisk High 
(>8G) CFA */

Thanks,
Christian

[1] https://forum.hyperion-entertainment.com/viewtopic.php?f=35&t=4282
