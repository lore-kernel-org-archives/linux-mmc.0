Return-Path: <SRS0=IAZs=3R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2339BC2D0DB
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 14:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA20207FD
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 14:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="e5xN+wGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgA1Osa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:48:30 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:33698 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgA1Os3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2020 09:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580222907;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Yd8278IdffBOus6O3P2vy23ykNevCPa9Nig0acvB1Ps=;
        b=e5xN+wGQNx5HpntFDQa8Aw+FAzlbvsGVdWT1h6fcRw7PX6oqJjlf5QPHowqNjhYdK6
        lCL+O9EeHakXQyRDAvetU9cEh5TM/HWV7RAKtFa7TAGL1H8GAvaAIxilJQslu6Vxn0Up
        Vd0I9AubDGhR6Fvjk2XVVETHfFbhNfPmpCBLyp4RgcTX/wFiH2dlPCPzTml1SOpcLeIb
        iAGzhvJOE4L2TIBvW4vRJiEtGHPEL6iBVf44MUohTjwv4Cvzkp+4BoRsy3PkKMg45L2C
        zSM6lIrMMO2hw57KmbhjuxjMkTx9yNf6eHqvMfi2m3MwaQtiOnmV/G9rZajZ2WL0Z83M
        CDYQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgHL/0viBvFGid1vGKl+pRiZ7f+cg=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:d904:eb1c:cd43:d772]
        by smtp.strato.de (RZmta 46.1.7 AUTH)
        with ESMTPSA id k0b198w0SEm6OUY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 28 Jan 2020 15:48:06 +0100 (CET)
Subject: Re: [PASEMI PA6T PPC] Onboard CF card device with new SanDisk High
 (>8G) CF cards
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Julian Margetson <runaway@candw.ms>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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
 <688f1943-5b81-6200-d4d9-38d21b69e180@xenosoft.de>
 <CAL_Jsq+r9a0BhvO4-VK59+Fh=9Ean=JgKwwxS+bqVz7=OWD5_w@mail.gmail.com>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <516d9b3f-426e-3f19-67c8-fa20368901ef@xenosoft.de>
Date:   Tue, 28 Jan 2020 15:48:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+r9a0BhvO4-VK59+Fh=9Ean=JgKwwxS+bqVz7=OWD5_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28 January 2020 at 3:16 pm, Rob Herring wrote:
> On Tue, Jan 28, 2020 at 2:01 AM Christian Zigotzky
> <chzigotzky@xenosoft.de> wrote:
>> Hi All,
>>
>> Which mailing list is responsible for the pata_pcmcia driver? We are
>> using new SanDisk High (>8G) CF cards with this driver [1] and we need
>> the following line in the file "drivers/ata/pata_pcmcia.c".
>>
>> +    PCMCIA_DEVICE_MANF_CARD(0x00f1, 0x0101),        /* SanDisk High
>> (>8G) CFA */
> Run get_maintainers.pl and it will answer that for you:
>
> $ scripts/get_maintainer.pl -f drivers/ata/pata_pcmcia.c
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> (maintainer:LIBATA PATA DRIVERS)
> Jens Axboe <axboe@kernel.dk> (maintainer:LIBATA PATA DRIVERS)
> linux-ide@vger.kernel.org (open list:LIBATA PATA DRIVERS)
> linux-kernel@vger.kernel.org (open list)
Thank you!
