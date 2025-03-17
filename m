Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39A17BBF
	for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2025 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249180; cv=none; b=RbXmbYrEu++uSvz8MLtxdRdzPm0W8dbxXjRl9lQl+TyNpk2Qouqirgbe6/nF5LyD444uJHqFb+q/5RhO0Ymk2pvY6FLPmSUPbOkdCSp5Nr4eA8sFAZ10BfBz/Pp/xoVVQIdi74LsCJHdTOAOnzSbpWz6SbB+IHrSgH6yVr2nQ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249180; c=relaxed/simple;
	bh=xtmNQAmiddO9PfxnK/vdLxIDc9tf8hJV8/EuKq1TCm0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=d16moEx6IIoOrsDjCaJM+972qGQgoMlTBlWKA1zdBG/Vwrpm9jre6a7FQqzJBkNwCdJJULwrjFvxL+M0iMy4fd2uiG+I1uB6/O6Q1SDSwNVblozvOUrg41E/9sPAX4ltuieWrQ2KuZ8hw+DkSbX9S/lCCd43Mr1+Q8RiHcL/jJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=digeJQvr; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="digeJQvr"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-601a8b6c133so2652267eaf.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2025 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742249176; x=1742853976; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8dAYBGS5lFqHpqqLaiZQj84sBiG0WpKfeLOq4SIiUc=;
        b=digeJQvrZM6XaT+cIa7PNlxs10nlv2zfz8W+OVUVflh7+MmxGfVKaUzTJZVy0Urf3B
         m4NFM+vHYX/b7GcZ5nuem1ctWsRW4UXPvs0HH0N92enll/ym6FlVz42e5E40FEIvFsbf
         geiIsPgI/BmrsKNXYUCKASMIpi//Sbp1/yld8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742249176; x=1742853976;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8dAYBGS5lFqHpqqLaiZQj84sBiG0WpKfeLOq4SIiUc=;
        b=daBX0I89QY20Bp8gXg7xwDNr3b6VJ4jmn3ivqOPxua6VNbMaWQKHpA2h6w7urmg8eH
         i4z8psRtmXaiemH2LJDU7HXHFmQoBsOeS48LXhcB7ET9kT1FaJ1iWFKE5oIw1CHKuz59
         sPCqFSgy5i0Z99fCiFU9J6EFKff8wayrRkfqcqTw5frq6Adj/fDRcQA1FdwVwl2MMOxI
         OKRanFxIfNYwXONG+BaTLwxJYJwUtR+tCgKlddGB7BvKMnqBIeXYOnHlPll5qhBA7OaW
         xQz+RBik9bgrEC7hyWagQy2iBG1qa2sZ0ibYdpixAKO0JcaUBhggjmsbqVkj9+dTDtpK
         1HnA==
X-Forwarded-Encrypted: i=1; AJvYcCX/b7IM2MYv7P3Dciz5tbAertBcu6lv5z9PQ03aJMpkdOmGXCEMU6MF7d7bLtAVeQ0uVBwXoXd44g0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9ZHcMrebZFO9wzUftXOlini87xyguw44Fxgq6lCQ3ezIeNQe
	vI9BEYwxMsmoXYH9APPJGRkGupkrl30kwB2lBelnZxbs0tCw9OdSPg7F8s8jdw==
X-Gm-Gg: ASbGncvg6spQev11RanSlVg96+WubyFwldHGTw145HABsRgmWQC++CK+RZZjhv0qTGQ
	9ClQNgUm8KyrLTv2i5unnX9RlU00S8GHhO6Mk1FlP+AbEGjzRY/VQQArlY4qRqj/9hnRXh3BMZS
	rft4lfKD9ea03v5Wqm8yyFwzhHgdeBgPj/a9u79BWzmfLKf7+phl2zYf5mGPBzXuPOZCx8vxsY3
	vIwb2PzR5ORgSsEih+P4A41CQWzuicRTVz62Zceq9b0kvqGhP9vy4dKeFSAihGUZbZvIWZw+T5l
	mxREpa/QR1Rue5Z482j1h5sAgb7kNwlXhvwSeIwrxgcmn/4bedEjd9zn1CDqlx4gGeApqptqW0d
	rEsNEURSInD6liqM=
X-Google-Smtp-Source: AGHT+IHnaexVn+wNtEptwMdzRuUiiapR8scruXC+PY3z3bzwyGdHYiE4KcGEWLneAJxno4ExoIYhaA==
X-Received: by 2002:a05:6871:6011:b0:2b8:b76f:1196 with SMTP id 586e51a60fabf-2c71a1ce256mr601829fac.19.1742249176621;
        Mon, 17 Mar 2025 15:06:16 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6712e5774sm2311980fac.31.2025.03.17.15.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:06:15 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Subhash Jadavani <subhashj@codeaurora.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Seunghwan Baek <sh8267.baek@samsung.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH stable 5.4] mmc: cqhci: Fix checking of CQHCI_HALT state
Date: Mon, 17 Mar 2025 18:00:45 -0400
Message-Id: <20250317220306.44646-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Seunghwan Baek <sh8267.baek@samsung.com>

commit aea62c744a9ae2a8247c54ec42138405216414da upstream

To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
bit. At this time, we need to check with &, not &&.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Cc: stable@vger.kernel.org
Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20240829061823.3718-2-sh8267.baek@samsung.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/cqhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 10b36b156562..ae9c184ed898 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -580,7 +580,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 		mmc->cqe_on = true;
 		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
-		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
+		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
-- 
2.43.0

