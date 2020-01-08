Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8095AC3F68F
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 09:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7EB2070E
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 09:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCUCtMPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgAHJjL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:39:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34129 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbgAHJjL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jan 2020 04:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578476350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y5Mnn5wX0vNSW7w6VGP+1iHmn8j5y7sqHokrvAxVOpU=;
        b=YCUCtMPUIQu9/Xck+1bOfdLpVifgGohimBH7BgUG1Z9NFiDJzN9QG5SLVB+Wpv3gdJuu4f
        9DzwjYks9fQ1PnO9KrE/XbcsI7tJI5CgGPG6MsC9ARbpIkqcFTD1beUj1nVZVbb2GJm7+j
        PVoNXYqVqYIfttc+QPYhE0mae5d8wYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-f7WKcBJON-mbUAoqU535JA-1; Wed, 08 Jan 2020 04:39:06 -0500
X-MC-Unique: f7WKcBJON-mbUAoqU535JA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACE75184B1E3;
        Wed,  8 Jan 2020 09:39:05 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-178.ams2.redhat.com [10.36.117.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 959395D9E1;
        Wed,  8 Jan 2020 09:39:04 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 0/2] mmc: sdhci-acpi: Introduce device specific quirks, fix issues on 2 device models
Date:   Wed,  8 Jan 2020 10:39:01 +0100
Message-Id: <20200108093903.57620-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

I know you have sofar mostly resisted adding device specific (DMI based)
quirks to the sdhci-acpi.c driver and I agree with you that whenever
possible, those should be avoided.

But yesterday I was debugging an issue where using the microSD slot
causes the LCD panel of a tablet to go black. This turns out to be a
bug in the DSDT which gets triggered when using 1.8V modes, see the first
patch for details. In this case I really so no other option then disablin=
g
1.8V modes and only doing so only on the affected device model.

Another issue which I had on my TODO list of things to fix is the Acer
SW5-012 version of the Acer Switch 10 models always reporting the microSD
as being write-protected. Here too I see no other option then a model
specific quirk, since some BYT devices may use a normal SD slot with
actual write-protect capabilities and we do not want to disable
write-protect checking everywhere just because it is broken on one model.
The workaround for this is the second patch in this series.

Regards,

Hans

