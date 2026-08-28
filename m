Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2835A397
	for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2026 05:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895612; cv=pass; b=RUKuuqu0VWBfXW1uIXOKU0S3n22/BtXAmcSizaSWiRq8d6ZQ8NVZz2dlMas/SRdLi/kEODvibbmX4tRj7oEQg/vwT4M+7i1F2D0Gnp0qNJpoy3nJI0HTZePBTigxbgRswNe1TSWx24wOBje+i1wR9RVOA1GwhhLGjKyuiG8j+mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895612; c=relaxed/simple;
	bh=DmJHBRIgTIHnDaysgbMYNL5Sxs3/1dzntpjOgveg750=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=eogu3vf3Y8CtfycXXmqwYfWQZ+vqECJ4IMSAxQ18Ltd+WltX62i8MmCoDSqcSgN+VVqDIbNHA/EyIfVjfatJORl2T+egVPpKvXPetm4fW0GnSZN9vcDtDdZjVlGOtTPLiPnypYcOOaVh3B0LGiIAPHVK+BCGOaGSkfs/yfNEBag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=ZJTEItq1; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="ZJTEItq1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d71e253c90so5975595ad.0
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2026 22:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895611; cv=none;
        d=google.com; s=arc-20260327;
        b=GPeP0sqWwZgN+MQ/bm2UDIEGQkEpWPCTDESciKLGiEjsdm2S+BWFuWJQQ44HzwYnB/
         4jkRZrOtdzQsSNeVOHb/DW1Apf3D0L2uzJR0b23x2ZRRfFxS5ovQjooGgK1PTh1tkurJ
         y0fK3o4rdgYs/fDcbFuccr7sflo4CcMB79t0i3aKbFb0FCzejkJ+D7cczoQXlSFSXEop
         l+GfRUJ8t7xhTfYKCNsyy4aWssnFGUqCC1w2xxK0wkeqjeb3nbfWWuX8QAr3YNCWavlM
         XFyaaHuLV878JQrLAhNqfppe7MCfrS+STIL/SKcbpDd+JojeboU3yskU5F2DFwz5+A01
         HQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=kX4001c5uQsdS+9FkPB6xzWvEC3+tpgtec4pqMg2mvw=;
        fh=Af8qhlVDc9PubbY04VGkLTWLesJNgMy0mBlXb/M1kP0=;
        b=SXmhMP05Qkf1+tc2eIfFRP3o8vCxNdC7+sOeM9Y6YhyvN1QcTtxfI1ExnsT6uMERJr
         zXHM749K2JBGDR2SlXVS3il9ydmFi5EtKLbykR4Me+G8RqspPV7Vd8CWIQcEg2E7pEIu
         Z4JUT7KvSgIVfAs8ntt0fm7yaf9pSjF1kIbnB/9/0z3QTyo2Ejh5gp/PwL+JE5uGN9VN
         eVye47oVZ0Q3ZdJUCO/LaQBHTwHRvOcf0qm6zEneF9rDsxDw7XxXc9gBARXVTEu/T0yK
         fvAjoSG1spPs5LOvErsYp1m3pPmX7iMAhfkZw7NwIRDwOHdwbFMTu+Rj1Rz/Z3nli1Zc
         wTsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787895611; x=1788500411; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kX4001c5uQsdS+9FkPB6xzWvEC3+tpgtec4pqMg2mvw=;
        b=ZJTEItq12xoOGAI1HFkhBLwY6OBKDzGBC/syyqVOHwSVSJEaCD/Eon+hhcTYeavnVR
         GATeFvxGMvthZA3Wc5/afyNKunazLGfrqC3ccBjw2egTSJPyWwHMizd88O9sNT9jOR6N
         dHejy9F3nTzZfBHyjfI36FY8oLcXKHO82X7Sioln1TZKo0/vE3lnzUxXL4lLgK15O+V8
         hX9U0kN6UIah4RDbAREZFJjLnVIb37ORALFMRQSBP1Uih7Vy1zOSX+zPZ6VIzjqe06ba
         VGQbyZ6/zCzpuje/Q4fvslGSxleSkj1N1bEEk3MD5o7gwUMyQ+4anhbGfpgNfmcvLaGR
         UXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895611; x=1788500411;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kX4001c5uQsdS+9FkPB6xzWvEC3+tpgtec4pqMg2mvw=;
        b=RYg0KaEyFqOF5hHyxz0RKqsviz71M1J1DAp2+XkOGFDW0bP+V337Q3qp4YV0DMn//5
         S5naqUL9bz59dWu4Fqgt2nL+r1Q8jsz8pCzd+I3A8bLWem0BSX7IJz68O/5FqiFpe0Ff
         aNGy7JKYD88Gq2hchMsdMm+xQKMh7t+8Su2Ie5LPCCKwntipr8GXtIdnXtYzw/r5QuUL
         5KaNCthWjAJKttU8DLdjuZ0j04c8lBH+DGnRst/Po/+8uP9E0Fs977FWb4lu4O+94htP
         d261wMGMmtducOpoqTXLaZWu8LeyLTCZqOQujsu6pmb93voBahRMwmJOzxT9MoyMdZFi
         RXlA==
X-Forwarded-Encrypted: i=1; AHgh+RpzwYe7qRJGg/ZAHzZNTRNpdaiDs/AG1EXuOArr4liXB8yAQ+a49LsiMzc0eieVDUC+Las9rgxzujc=@vger.kernel.org
X-Gm-Message-State: AFuF++khUyS1ev1qp+cfiXBL0DjGaLcoLDMKzXOodrfTEKE/l5yHLTiT
	sx/A2wGPxL4dCk9Gxe79wfBtqPhE4T9M1EAu2WvxvjgYeEnW1pF5SPGS4xzuqBrvnLXgeuP4Q7X
	pecjQMJ1cSYuU8jVwp4EVSeHQTkeSqLwJPYvuRoJIECOy9wu1ZXfV4Q==
X-Gm-Gg: AR+sD135+FsaXGOTZvQy+cEWRLeXR3qDeuhvcMyDq7yAvCI+IE2Cqz7LRcOHaVrFIQq
	0iLlDUE6Es3uoUowk7MnTYuxjiX6QiB/BWm3gHlwVixotSb1w/t2ICUYHfwiozOsyFLo9xETpkx
	Udpj05Uye5h69eJab+3LtCqkghXXeZUMveruSYShA+Swcm157VAPB5y7Rx1slpT8SB+yFstmhoK
	kIQqsRdeHInmAtHjuTK9ilpuGIuVlQ40GHu7+J1ofCPDG21CQIsrT0d3tfCvhSRHAfuBWqw0tqu
	uwnnkNScVhJAjEHSg66l8xX8Id3+SSs8KdpJ2ZPzpbCHE9rYakIeTJckWLy+L1G242oYVyRCmpu
	dGnRS/+Yc8QCKyHzkd/eWIc6IY42yGL0o
X-Received: by 2002:a17:903:1ad0:b0:2d6:f9e2:af7f with SMTP id
 d9443c01a7336-2d74dca2148mr90214615ad.1.1787895610029; Thu, 27 Aug 2026
 22:40:10 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:40:09 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:40:09 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:40:09 -0700
X-Gm-Features: AcwNN1V1xXokhQQ7CNk4vlQXfjGfvMBUshkzw2uzUqY1xboKWA3St6UdW4awAgc
Message-ID: <CA+0ovCiuSWBLetbWVJThDc+LzRU=xp+FmZeGddF3vOd_0UevzQ@mail.gmail.com>
Subject: [BUG] ushc_request -- URB submitted while already active: WARN in usb_submit_urb
To: Ulf Hansson <ulfh@kernel.org>
Cc: falemi@asu.edu, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/160-mmc-ushc-urb-submitted-while-active/

  WARNING: drivers/usb/core/urb.c:379 at usb_submit_urb+0x7b/0x18c0,
CPU#1: kworker/1:2/992
  Workqueue: events_freezable mmc_rescan
  RIP: 0010:usb_submit_urb+0x7e/0x18c0
  Call Trace:
   usb_submit_urb+0x7e/0x18c0
   ushc_request+0x3ce/0x8f0
   mmc_start_request+0x202/0x2d0
   mmc_wait_for_req+0xd9/0x240
   mmc_wait_for_cmd+0x183/0x2a0
   sdio_reset+0x1fa/0x3a0
   mmc_rescan+0x6d3/0x1020
   process_scheduled_works+0xc99/0x1900
   worker_thread+0xa53/0xfc0
   kthread+0x38b/0x480
  Kernel panic - not syncing: kernel: panic_on_warn set ...

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
