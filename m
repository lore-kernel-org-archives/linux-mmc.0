Return-Path: <SRS0=IAZs=3R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418FDC2D0DB
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146F324695
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220977;
	bh=3UIW/IHLdI4xz17lXPE846OTxnzJs5ZmVN6cdtT6nmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RGZdvoQfNr5ghk3ABYxbU3P/HhO2sGPxqyW/iZHsU0hzSIvbqr2TMeGJ7PXDyl735
	 hfG6Avd7OcGP5LEmu+2M/9ebu7an3o+VehGuuYkNqTeJih470LUaLCiTv/RGx9OoQ1
	 MP5Jn3UXrR0GOCJiUT8UK0Dnf5Lf/p6dElLhaZDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgA1OQP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbgA1OQP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 28 Jan 2020 09:16:15 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E1EC24694
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jan 2020 14:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220974;
        bh=3UIW/IHLdI4xz17lXPE846OTxnzJs5ZmVN6cdtT6nmk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YR/KY9hSgSdZkhrhtUt/PueSWeaB97EHt3KMOoY15fChoo/pJUdJgwLa+NI1CFKdc
         ujorkuvevVDOdgyKh8i5A2+Onyn7dNcYo4pCBM5ZbN5d4x0xr8EsmjjuoKrnchMZL7
         DicT0uOQdmp8SpqBoXfsbOyGpaK06bJIqjHNd+bY=
Received: by mail-qk1-f178.google.com with SMTP id w25so7756487qki.3
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jan 2020 06:16:14 -0800 (PST)
X-Gm-Message-State: APjAAAXjsQvJvnc0jML6nB7da/+dfF38P/HEbz6C0nK0vKiOIHh/3bLJ
        Rexsz5QOmOK9nHmQP5jdbJoS9gWMQCfCdfD7Kg==
X-Google-Smtp-Source: APXvYqzbCxAM39CpEUYUcKxEjgH8P95qQfbv+KN0KyJyqCnsEckJr2k9Kwcpqh/oHoYBbaCcEjSNRLRSBkJznfqv+L8=
X-Received: by 2002:a05:620a:9c7:: with SMTP id y7mr22183123qky.393.1580220973686;
 Tue, 28 Jan 2020 06:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20200108093903.57620-1-hdegoede@redhat.com> <20200108093903.57620-2-hdegoede@redhat.com>
 <61bc9265-ece0-eeb6-d4a1-4631138ecf29@intel.com> <8d67882d-04a8-0607-be4e-c1430b7fda21@redhat.com>
 <84a32714-ba08-74a0-0c76-3c36db44dd68@intel.com> <93446e09-5f12-800a-62fa-bf3ecea7273d@redhat.com>
 <399ac7d5-2518-799a-595e-f6b6878cf4ab@intel.com> <a9ab8946-c599-5f83-7527-2387a9e82e8a@xenosoft.de>
 <CAPDyKFoydOuSE=Eaq168=2_Ycouo7hzyw+RZXhGq7q4D4Qe8TQ@mail.gmail.com>
 <8736c5hyhr.fsf@mpe.ellerman.id.au> <688f1943-5b81-6200-d4d9-38d21b69e180@xenosoft.de>
In-Reply-To: <688f1943-5b81-6200-d4d9-38d21b69e180@xenosoft.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Jan 2020 08:16:02 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+r9a0BhvO4-VK59+Fh=9Ean=JgKwwxS+bqVz7=OWD5_w@mail.gmail.com>
Message-ID: <CAL_Jsq+r9a0BhvO4-VK59+Fh=9Ean=JgKwwxS+bqVz7=OWD5_w@mail.gmail.com>
Subject: Re: [PASEMI PA6T PPC] Onboard CF card device with new SanDisk High
 (>8G) CF cards
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
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 28, 2020 at 2:01 AM Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:
>
> Hi All,
>
> Which mailing list is responsible for the pata_pcmcia driver? We are
> using new SanDisk High (>8G) CF cards with this driver [1] and we need
> the following line in the file "drivers/ata/pata_pcmcia.c".
>
> +    PCMCIA_DEVICE_MANF_CARD(0x00f1, 0x0101),        /* SanDisk High
> (>8G) CFA */

Run get_maintainers.pl and it will answer that for you:

$ scripts/get_maintainer.pl -f drivers/ata/pata_pcmcia.c
Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
(maintainer:LIBATA PATA DRIVERS)
Jens Axboe <axboe@kernel.dk> (maintainer:LIBATA PATA DRIVERS)
linux-ide@vger.kernel.org (open list:LIBATA PATA DRIVERS)
linux-kernel@vger.kernel.org (open list)
