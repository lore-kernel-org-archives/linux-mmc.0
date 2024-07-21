Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D5D184E
	for <linux-mmc@vger.kernel.org>; Sun, 21 Jul 2024 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721528426; cv=none; b=OBi919TUMXzy02AMMtoJ1WKrQNemQIDEnoRCdUICXuvO9/kVUPwPRvwd5kD9hKcJKiHxY9d1k3vjpgM6R7cXdDdqkrM13PSY/UuJxTTC00r79P1UKUMqldfCIs9GY/gsX7pi6nLS/GnmY8FgAgomYPSx8sJNY6aGZviKX+qY2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721528426; c=relaxed/simple;
	bh=lrfJRIwsoTczV75bX8oTMv2XMvNk9iolDDapu1sdnNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WBXFMDE4QZ3NU8Sa1lZ5ErurTnCgZBUO9y417caxm4+TikhScwsJy3srJXIyHlZ7KVIyhWH+LiASryVcTL8MQU4FaDKAlOJQNaQ945jq27eik6FHKs+hAhn4GkDnCVs8l9RKnslII8/aA3X0hEgDqm7beXicvzS0q6R9CE0wQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b=YdO0nJww; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="YdO0nJww"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d6301e7279so2035205b6e.3
        for <linux-mmc@vger.kernel.org>; Sat, 20 Jul 2024 19:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1721528417; x=1722133217; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ennaqB4p4f3xFXNjcWADeIzx2b4sNtsy8igfZJ0Q6aE=;
        b=YdO0nJwwR5vEPMNk1sxJokHwhzXJW+CKDbKZtEMqQrjISTU/leXdy43udW0nappXxz
         axsF7GeFphPi4SnAUzscF1yFK2d6YPS73fkJHYstiQvtiNH6T+Gf5Z7pA/yKRH35z5Uc
         vizkR4bGb8tl5G5ReUChdF/x6WMUrA3DooNKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721528417; x=1722133217;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ennaqB4p4f3xFXNjcWADeIzx2b4sNtsy8igfZJ0Q6aE=;
        b=QGrcXEPdT+lTPPVfqwsKNxNzXrYI2wCdijQAjR1J45X3TPC7uFUdrVx+yIfZEnwye/
         AGxsExO9OfjK80QeDoVSAMFRqSMkHEBhISSk6X3HcavcLYCkj0WNQ2NmoF/7Yo8Ox7/e
         WCw67vXBgksEggJWoFZxDmBvjaQFYFqavtDbWwX3T/+RXo75hWmaMsVjqGFoIdYbqMfI
         834XqzEsQFr5tj6M6nf4s9zfydMB71V5O4+1utq89F78Xp9PBm9iF0Qv6KdJMqZ3DBJJ
         IX4sl+eVMgkakhm+uy9btdYg9ndJ90z1ilJLrcwlewEF1/mIWdefH/u8JYbMqjZ6d6Cy
         UJCA==
X-Gm-Message-State: AOJu0YyIuTy2zE5fR8cr8YCGBLNlFmh4a7ar6eqVV13ZwniM2IW2Wwfe
	rEokU62P+bQaBEr8Ml2GWDMVPfW5fN1nlCe/U5MFj9z+tVQphgB/w4Akum28GeDfgzBagYbImg+
	W7mU=
X-Google-Smtp-Source: AGHT+IEtnZWBznYPj1NLcJ7EbbJAjToKPgN5lF8YgNpC0tpEaeMbZnfBuSxSxgHt+agDbFAQWZMhXw==
X-Received: by 2002:a05:6808:1a1b:b0:3d6:32b4:b8fa with SMTP id 5614622812f47-3dae97c7932mr4489624b6e.13.1721528417224;
        Sat, 20 Jul 2024 19:20:17 -0700 (PDT)
Received: from 378c8c72e398 ([122.199.11.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f291f10sm28752585ad.103.2024.07.20.19.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 19:20:16 -0700 (PDT)
Date: Sun, 21 Jul 2024 02:20:12 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: linux-mmc@vger.kernel.org
Cc: rudi@heitbaum.com, avri.altman@wdc.com, ulf.hansson@linaro.org
Subject: [PATCH] mmc-utils: create mandir during install
Message-ID: <ZpxwXEKy1bAOCes_@378c8c72e398>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

fixes install faikure when mandir is not already created

  install -m 644 mmc.1 /usr/share/man/man1
  install: cannot create regular file '/usr/share/man/man1': No such file or directory

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 9e14a5c..06ae0f7 100644
--- a/Makefile
+++ b/Makefile
@@ -53,6 +53,7 @@ clean:
 install: $(progs)
 	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
 	$(INSTALL) $(progs) $(DESTDIR)$(bindir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(mandir)/man1
 	$(INSTALL) -m 644 mmc.1 $(DESTDIR)$(mandir)/man1
 
 -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
-- 
2.43.0

