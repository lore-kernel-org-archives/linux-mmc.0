Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849E35E529
	for <linux-mmc@vger.kernel.org>; Sun, 22 Feb 2026 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771803589; cv=none; b=gY48h8PSCiD8Umg8866DDB8R/8M4b+vaQ6SrwAnH/X9Y7d55j1imRk7yAg8fSmcfhF/SflpaKUb/kVSBJtJcTsjP3AifJJGeiFi1kd1VZFJw2uXHbUJPqoTb5wa9avQF/obVQteO6v4EKlvag3USveXz+J6HVe33riPSSt2IxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771803589; c=relaxed/simple;
	bh=Yy4ILKkVMccWwWDSwzrCOpDK+U9LeLt8oVFaVSwUVFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDJZEah2WuOdqpNdSohewMKdxc2XE6lxgWdHqRvm4wKu7bo6ZVaKQO4GvqARSD0yFxKIYKeqygHcNGOug6mSSqED5Iocit08Ucb+N55KxJR+jAphMeCeqqSzm9UsKkKtS09Opo6tEzECKFXVVDM1Ym/V+vdK+KxJZddzQlDYSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkHi5Fh6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tpgVlsbP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkHi5Fh6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tpgVlsbP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771803587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDXCcMEUfWQMTpwCjr0nWr33qY/+dpyddxAHhbIp6Fc=;
	b=MkHi5Fh6ClB28VUoYEfNjeejuofGsr2X8ZXNTKgvEUc1C+TVMNY9SSBkinT69HLrlnT1Cc
	GZ4BNZ/mpIJUjbSe9NBSUIHw0UHJS8vlc4PMlq3oFJKHHQ4t/d9LkBOrB4IOOBz8Zlftmo
	PPz1e6aQoZ/FZXo/JRWHZ/VtYdy9h5Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-iPE9XrMTMNiJXX4t0HTJig-1; Sun, 22 Feb 2026 18:39:45 -0500
X-MC-Unique: iPE9XrMTMNiJXX4t0HTJig-1
X-Mimecast-MFC-AGG-ID: iPE9XrMTMNiJXX4t0HTJig_1771803585
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-894709fbae5so479971666d6.2
        for <linux-mmc@vger.kernel.org>; Sun, 22 Feb 2026 15:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771803585; x=1772408385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDXCcMEUfWQMTpwCjr0nWr33qY/+dpyddxAHhbIp6Fc=;
        b=tpgVlsbPP5R271oLDE3QGkqaZuaNLUHzkn8I+rwY/QSnaB1v94qtOQ1WqVPpsCc+gJ
         EZ+eZ6F9wZWp28Xqw+cQhRLL9jQ07qupu2ZqAiCIVYOdhbfE21uGuJrM5+9I/3KscnjE
         vyhTHV4Y5Ir+vcleBAZM+ZuMTTguadXWmLDtNqhlI/70eL9DK7xKzKpEzReCdAXqrk57
         7sYX72L8VgAxFmG4Dk6EjdAFVraH7+bdoJVJ0Hf6lc3e8l94KEpEpSPlO5yyLKlX89zD
         0QWa220dPnAV53DS5xVWq2yqOXys+zNlf7m+w6xZK78IGO4a2XYIg0u4bke+rIn6wBS8
         bbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771803585; x=1772408385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cDXCcMEUfWQMTpwCjr0nWr33qY/+dpyddxAHhbIp6Fc=;
        b=cFVDla4RszkQvGflnwMlYUPFMH53gpeuFS+5Ymbqtm3xjIODLARifYk1I36dWbzux3
         To7WQv/cnJ1+vJVBABkha+id6K4+RYCVvCLayaAuJDXBh609Y7uPwl1AvBp9yQeylxoO
         /SB/mHLFUJni+0AAMOd659k6sYFIiGyZv9Wb0rT+YbCxsMWdzdMwkr37WYs184BwDPwJ
         lG4lWApj0EoxniU6TR0nQhTZzVL9Xplut94/i/p7mNUGpXHJ5pOYbpFAH6Ksuxi0oOfW
         +cKGK4qh2d7W9s/avvYyOZ9I9oRZIQi8vq33JorFRlHYMeqV41GpHpJhyqV7ax49JxBb
         zAig==
X-Gm-Message-State: AOJu0Yxg7ziD6XoFQ4+KERs3ZJLxBPTT3Nhr2bnApKkk+Xdb8eRIevb2
	8KTqlgZyrQPKwhQpnypRIvdWP/gzd7owVXIu508OXhtlIpftE+4lRWzpypZnZ+LPhXhIVcd28r4
	ZHjICWS7uNeSY7cQ/QjXJd97JFQitJkwEcQcjTODbA10eVYOmnvKAJ/wLqKWVZA==
X-Gm-Gg: AZuq6aI6+TO8S4gVa2BQ3IxNSrniJGhZMmlwoRfzvpUo1k+3Zuvx8Gn/uy7gnXsyrke
	3lX+JIoZ3aIHN+QJV4a86m0/xBZ1BtGyUut8xVA3CEFO1kmCNyXgYZ1zIw9dwpqmTkxLFwwx43Z
	wWsjlRnRj42aNbibiImIsd1FdCUA4uZFZ90saRDt27Yz29PcqLSyt/OgCufvCDEjFrylAu/a7Yt
	1fOA4c5IibnaIKfyfp03LDHlPY0+7tbPgBucX04DEwaZJQ/jOK6B8c1QAhX/dIIc8+4Ka+TH1ca
	I2eDDZOKxrCWGqZQzCVRWitlWngzJ50zxoukIms5kNv8kIrm0JfmsxKWzqOkmFx22Svct4yq1hF
	oIdLij9kbAYurd+BB4ZkCWtwa3a9zicQ5Z45eq82lpzcIrI+Sl4TavAYeRftv8A==
X-Received: by 2002:a05:6214:21c1:b0:897:190:c26c with SMTP id 6a1803df08f44-89979d3b841mr101134676d6.31.1771803585189;
        Sun, 22 Feb 2026 15:39:45 -0800 (PST)
X-Received: by 2002:a05:6214:21c1:b0:897:190:c26c with SMTP id 6a1803df08f44-89979d3b841mr101134496d6.31.1771803584699;
        Sun, 22 Feb 2026 15:39:44 -0800 (PST)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d101ceesm577297285a.34.2026.02.22.15.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 15:39:44 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 22 Feb 2026 18:39:14 -0500
Subject: [PATCH 2/2] mmc: sdhci-pic32: allow driver to be compiled with
 COMPILE_TEST
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260222-mmc-pic32-v1-2-110382af02b0@redhat.com>
References: <20260222-mmc-pic32-v1-0-110382af02b0@redhat.com>
In-Reply-To: <20260222-mmc-pic32-v1-0-110382af02b0@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=Yy4ILKkVMccWwWDSwzrCOpDK+U9LeLt8oVFaVSwUVFQ=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJnT97NHZRWsJFd87pUH/dN/l+S12IannccMnzOddxgt
 96vJXyFHaUsDGJcDLJiiixLco0KIlJX2d67o8kCM4eVCWQIAxenAEwkgJ+R4YvnI1fJqoyjEudE
 Vbn1Dhh5HFW6qx0odqcjauajKQsU0hj+CslvvvJydqSe5MRu4Ze169cs/Vuy+cSpg7+Xb/vuyO2
 hyQAA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

This driver currently only supports builds against a PIC32 target. Now
that commit d6618d277c1a ("mmc: sdhci-pic32: update include to use
pic32.h from platform_data") is merged, it's possible to compile this
driver on other architectures.

To avoid future breakage of this driver in the future, let's update the
Kconfig so that it can be built with COMPILE_TEST enabled on all
architectures.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 6d79cc9a79e22d80bdb8977a8182d814ab91927f..4ca55c025159ee4c6b70dfff0ea3a44ecad98ff3 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1044,7 +1044,7 @@ config MMC_MTK
 
 config MMC_SDHCI_MICROCHIP_PIC32
 	tristate "Microchip PIC32MZDA SDHCI support"
-	depends on MMC_SDHCI && PIC32MZDA && MMC_SDHCI_PLTFM
+	depends on MMC_SDHCI && MMC_SDHCI_PLTFM && (PIC32MZDA || COMPILE_TEST)
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  for PIC32MZDA platform.

-- 
2.53.0

