Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1D35DD19
	for <linux-mmc@vger.kernel.org>; Sun, 22 Feb 2026 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771803587; cv=none; b=GBphH64ymJpOaZ+5VC1zFQ8l2b2pW8BUYblhPZvvF7KEYogcL5566GY236ZObyK3f50Vq1lghR5PO4yqgb0Jb+LCz4ltd0X1gSnfiC0YFjh6e1QQY0CsLwGJJds2XAg7tkJLIObSZG7oHXhh/BnlXZ1CNX263QrXB0abWiMnz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771803587; c=relaxed/simple;
	bh=IOOYa4RPQMhTzrckY9rEKU4xCWAEgo+p6cC7E0Yo2iA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kDqTg++7c2OAZFe40jS4rI7ETaqAliOCNZiVDKapU7TeEVTpDAd8sZxMLsVUy+TAJLO6/JPl8NnyI/ruZ8O/HDIzpgO2eeDpa5YEXo6LZj7m8eRvougxOmxYH2ZvudsCeB6mpUu2jDXmX/QJYbLW6g7VEr0xdIgE6CtEiDdIo6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eewDygmm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQQzwRoj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eewDygmm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQQzwRoj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771803585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JXVcS+4g53Heu2dEII1zYREH8+sJvQtk7EsnKftOFmE=;
	b=eewDygmmDfiMLvkCwE+zHmRzH732wIMpnPK9r2DZsQRe7OpdJToZwb1/5va5sJYG+a3x29
	6qw3j19S9sOywBsQf1+RZfV3WbHxswc4zsKqKnpRNwda/0CwMYiMw4QfeYvAOOFXvDGoal
	hAgOakHtVoTDIlCu0pWMMchWfpImM94=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-ul_-lan0N0GkCZF8e0XGmg-1; Sun, 22 Feb 2026 18:39:43 -0500
X-MC-Unique: ul_-lan0N0GkCZF8e0XGmg-1
X-Mimecast-MFC-AGG-ID: ul_-lan0N0GkCZF8e0XGmg_1771803583
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-506bfa0441aso300931051cf.3
        for <linux-mmc@vger.kernel.org>; Sun, 22 Feb 2026 15:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771803583; x=1772408383; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JXVcS+4g53Heu2dEII1zYREH8+sJvQtk7EsnKftOFmE=;
        b=KQQzwRoj4D0IJmQOAZG1AF7uM6frpj2s3T/UMOtHRPif6xU3z/5XIH4+s0RoDe5e3n
         rZzCRCmup2ZTH3B+FIUs7g0MiW2LrkFEkvkdifNBkiQz5qQpXV1vL6UyloXMZblsj+UD
         hj/O+jUY8+yjxDQvQY4ZxmrDxVXmLlMloIqn+an3atv+Yhnee/cFDlWpCsxBaiGmPPDI
         zjdvjUtRX9NOuLEYYQG7xNVe/3skXCzff6TdFvZ/uPTHoN3TmUPACr1B2m3iNmZNCrUQ
         S9TH2JpnboOeybAAvFcRjIUUZFXPvZOuZVNdOP+4T5B3c7PPH89A6siy/1ctxVx3d++I
         AJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771803583; x=1772408383;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXVcS+4g53Heu2dEII1zYREH8+sJvQtk7EsnKftOFmE=;
        b=Ox8kxBUp7442mKfly0p3XRe1jonKOvrq09y34DTfOl+NOvraWYznUkB/cyJQ1SKRzS
         G8oMr4lW+Ev5KKESWPA4WOnsCSz0ka7m39bPOYqnUAkRV6v4r7AT/Qm4DjLiuXn0QD40
         +W/bwqng3GEnYzhJC4O4nYLr5IQUtEsTvaVp6P8fvyNUCcwMitmZ3aBYln1hV6Glms4i
         oNHZZDaPiXXwx4pYqmy3cSsitrtbgVFarCMQHPK7xSi8RjipJT0jJ9vn4LjaguRAFBIH
         aHfEuGHH3DGAFXWZNRKuKedtBM7EDaJzADqkW9xR4My3uEGKT2J7/1SjQIOTIqghaleN
         rXng==
X-Gm-Message-State: AOJu0Yz1UyVJ5wS6Fnl5EVOlWYhlL8T0aJvY4xFxE12NyKMyhJuNjlFr
	hpp7RQHLRxdvkM47/xXPU7SLDEm/ASqy64DnBcyXLbD6mZiz1xNhDjs2L+LCkhv/nXOnzZFO/V9
	p6TSilzpatOnNS76W8rzwn2a4bj3frzR0l5lEexC6gHYymmb10as1oPWrhToAEVUvfGPjrg==
X-Gm-Gg: AZuq6aIs4H/7AO29YKZb/aEp4eCVzDvhpAP4xeAv3WzddQ/l2TnziDOC1ZJOg4MnZOo
	I0TvNd+7n3DwTq1YWxLYOkmbgE6Kcmf2aaGc7uIuQY/kkCmAn4GVfga9xRSg+iQnnV+QDyi+czv
	oSHES96NWASOsFJUKl0bPGsGfzVkFhAoxGOh/7GoqhkOy3aGfe7dXpbVlTZ9WBlLUP9b0OtUsUn
	IKZEK4g30ibuD/Z+ACN4oN7tarcaLcOMyijSG3toZV+53PNMm4+FTKAuH0RN4o0r+tGKyZiGRsq
	gmlETROaMGbZKsMq7xGev/xDO6/lqkjxL+sp88oVyf11Y+XHmwSE5Eirsb+z4/joQKF4h3HrVEp
	odfpqId1zXnPelcW7NTFxBB5vyjh8K1p4O8DkFDN1A1UQ/f/9CRFKekFyIb9uTA==
X-Received: by 2002:a05:622a:1485:b0:502:f291:615e with SMTP id d75a77b69052e-5070bca7b27mr90674281cf.52.1771803582836;
        Sun, 22 Feb 2026 15:39:42 -0800 (PST)
X-Received: by 2002:a05:622a:1485:b0:502:f291:615e with SMTP id d75a77b69052e-5070bca7b27mr90674141cf.52.1771803582466;
        Sun, 22 Feb 2026 15:39:42 -0800 (PST)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d101ceesm577297285a.34.2026.02.22.15.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 15:39:41 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 0/2] mmc: sdhci-pic32: allow driver to be compiled with
 COMPILE_TEST
Date: Sun, 22 Feb 2026 18:39:12 -0500
Message-Id: <20260222-mmc-pic32-v1-0-110382af02b0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyMj3dzcZN2CzGRjI11DY/Mk49TEVItUMzMloPqCotS0zAqwWdGxtbU
 AfX4dyFsAAAA=
X-Change-ID: 20260222-mmc-pic32-137b3eae8e66
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>, linux-spdx@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=IOOYa4RPQMhTzrckY9rEKU4xCWAEgo+p6cC7E0Yo2iA=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJnT97h93pZTffpA2yiwRu5C3n4TKw6Y1mz9ntyf08p0
 TXfG23XUcrCIMbFICumyLIk16ggInWV7b07miwwc1iZQIYwcHEKwES6TjMyzPmy+k6eSDi/usaZ
 kBVuTYt9Jv3VvTbrC8ORf7fuSf1Mn8rIsLvtYNrL1S+WMWs83znh5IXCu0fvrXqSs+Xwefevnyx
 se7gA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

While migrating a pic32 clk driver off of a legacy API, I mistakenly
broke one of the drivers, and the issue could have been caught with a
simple compile test. Now that the dependent patches have been merged
into Linus's tree via the MIPS tree, we can now enable COMPILE_TEST
for pic32 driver in this subsystem.

While changes are being made to this driver, let's also fix a single
outstanding checkpatch.pl error with this driver.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (2):
      mmc: sdhci-pic32: add SPDX license identifier
      mmc: sdhci-pic32: allow driver to be compiled with COMPILE_TEST

 drivers/mmc/host/Kconfig       | 2 +-
 drivers/mmc/host/sdhci-pic32.c | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260222-mmc-pic32-137b3eae8e66

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

