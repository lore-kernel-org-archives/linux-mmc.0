Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137418;
	b=xUQb0QRxkVkQ1HzcE3LIifh9mcyN5WzpE/UltHAxgpQSZHhdJKv+mpdiXfQb59X1kdR5
	 3SkbmS8cEo/eOxnbbWqU5d8eFFR2EHRSEdaZDVwz490v2Pg+5licBDwVRb/2OFljP913g
	 UVaJKG8NgslDb758UWblRl5TCs8ofzLKnWdojLyB7seByZOXmIgC1PHSq9VEp1WpEt0/i
	 JkUFkXN+I3o/wTam0IKs11f8O/dFNOJ8pQ6hUxavSS2iWVKhH0clNaXArdKMFv4SIb0lY
	 KZ7A8SvSIwBgVAYKjUAhlpcI4DILMv/Q2y443jjeoFTJ/oP0XSUT77sbs2VTWYVXUGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137418;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=slBsEbEawi73L6tRBR2NM4PWR3iOJSAaGI4BxGOpHM4=;
	b=cujpzONMcaKAmlWxYwbfiJk+UAxKIXRijAzTbfNOOjWliA01ELXsKKUfVEevIGa/j2vn
	 CJzlAKXR5pHIpxGXU6ORhVgoEU02P62CILHjx5hQoHIa25EdYxkWe25vK7QZ2FnrSe2A6
	 x4nKOEc3EknH+rsbwNuG4CUd9nM4+lExpdMza9PhRMXANswSPCGTUrVlDu0ejcQYDOxjy
	 QDuUwBT2+CCrDUy/s7Y8UToIc4Twi+zQ01rYsf1xrH8IJTTo9nRChy6VeID+Tf1O5iKoU
	 U32ncMkS9lRwGq0t+h0iwMbyfr+jy9PVvKz/hLWp5UOz9NYP2OADvokDPTAIWphlR5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GMVk9KYO;
	arc=none smtp.remote-ip=95.215.58.60
Received: from mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A18606A320
	for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2026 01:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A18606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GMVk9KYO
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=slBsEbEawi73L6tRBR2NM4PWR3iOJSAaGI4BxGOpHM4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795137414; v=1; x=1795742214;
 b=GMVk9KYOY+7VlYVcuJkyW7QbapX536kPoU7Rl9R41x2V9MZoky1c5mlSN9kLN5v5CAj+g7PO
 JkHmb6KL5930QmkvpGXYz/g+a9tvi9sjblMGsj5MHHkdAonRzwVcaW/D3NRPQpG/1Wd7odSbsTS
 Y/qEv3FEEYvU/zcQiqcxIFnw=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a0a279a59a9ecb88;
	Fri, 20 Nov 2026 01:16:54 +0000
X-Mizu-Trace-ID: a0a279a59a9ecb88
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 02:16:49 +0100
From: Luka Gejak <luka.gejak@linux.dev>
To: linux-mmc@vger.kernel.org, ulfh@kernel.org
CC: Luka Gejak <luka.gejak@linux.dev>
Subject: [RFC] mmc: virtual SDIO host for testing without hardware
Message-ID: <489102F4-2EEA-42CC-9858-AF8B9B4FFD5C@linux.dev>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

I've been working on a virtual SDIO host and card simulator that allows
testing the MMC/SDIO core and SDIO drivers without needing physical
hardware.

It uses the existing MMC core and supports normal card enumeration,
CMD52/CMD53 transfers, interrupts, insertion/ removal, and fault injection.
There's also configfs/debugfs support, KUnit tests, and kselftests.

The implementation currently adds around 8,000 lines (I know that's a lot,
it will be smaller), including tests and documentation. It's working, but
I'm still reviewing and cleaning it up, and I'm open to reducing its scope
significantly.

Before spending more time on it, I'd appreciate some feedback:

- Would something like this be accepted upstream?
- Does the overall approach make sense, and would you prefer a smaller initial implementation?
- What kind of use case or demonstration would you want to see before considering it for acceptance?

I'd also be happy to take full responsibility for maintaining it long-term,
including reviews, bug fixes, and keeping it working as the MMC core
changes.

Thanks for any thoughts or suggestions.

Best regards,
Luka Gejak
