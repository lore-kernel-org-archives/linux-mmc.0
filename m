Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35614AD2B
	for <linux-mmc@vger.kernel.org>; Sun, 13 Oct 2024 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853784; cv=pass; b=lnssTZr4167dzQkj33pOxnnMGKIc26U/Sl4a2k4m50d+Reh5OZa0iPlfes1s40Ee2NP0VQVMEP5Z+hoErcp7rT03nxO/Q3+uq2oitG1RH+sevEsk/6rlx6djNRALCoVBHpQFlVcSFTYCWyTbNoriFgGMZulyWI3Gn7clVMTVfno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853784; c=relaxed/simple;
	bh=UIfIqz76YkefJGbtPhSE+ZJxvHP4Ag6RclYVcaDtKf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=n1D3v9P5Elifo6nYsBCMUCt0siHMQCr+coxJWlRMGQoVpM5lqmYNomYwKOuMnnrGlMOLiMNI2Kc1tZhRrB2ODXpCOYI+lg9DUg9ey1Fl7l6MWV4V5iZdD451qtZEtgq7Rt+9brkqWnnOKupxlLX1q6wRotqbIQOqYc4jxbVW2j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=HKiYsxgd; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=+5YRN7v2; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="HKiYsxgd";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="+5YRN7v2"
ARC-Seal: i=1; a=rsa-sha256; t=1728853774; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HkPH6fgenJxuWqyiA2R+MNSpTSxBc4uVgTgXw2PKom7laDrXjH9mxdjKVEzIERIBA8
    KWEf63dJS2LXlACy9+4DZgih3ylVKUx19/19Bor3sPXcI6GA0HrxnFCALxCRfmbgPucT
    wXoq2LWkcQfcYIKPIYuVsCiMbyE48dv7Lw6J+A3rqp271a6gg3vRHyvbOBls/flWIFye
    8MsYn5/miLDSYMttLp7/6R0SFLeBnEc9d1vOMUlrxOJCkDp21qb2q0MlWF8Lyies25Xh
    YEKvn03u1HjxMPl8/MBJjLMtbGspg/29lyRrmzmkDumv3ZWIcFKU3q9c62ouRSXPD20l
    UgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853774;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=rKmS070uHKnpPAJ6FiJ+YjLd8iwZ2g9Fnd6v9Uo1Nzs=;
    b=ENmhym16lE1odVkQ88UA5bexUYtvFAbLBYtBPGo9ZpNc7TMNgUQ73iV/z78wmvw5ej
    JrWfcAyh13Lw8DVmiUfBjjNQBultVPCFvQgRPasTGw4kgHlCVE+CPvOYX0qvuGJzv4w3
    bWQVmNKNBeU1PhNzBAVAH84m8uzRkVVnfBcNtTel+YxgI8zEvep1EBXiK6sZRoEaZDcA
    HUFX9eFzrtf9kW5c9MHVIdP1pSABcUkerhT9wXtn+e66Oj88gSw1dToUJPOufJkMqHKY
    UP1tj3eAC7cNQzRUyYFCjQe4vVk4Dmnl4yIhqppxhulvpgjnDzn+MhjIVQBeO8LTjiQK
    ORmg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853774;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=rKmS070uHKnpPAJ6FiJ+YjLd8iwZ2g9Fnd6v9Uo1Nzs=;
    b=HKiYsxgd1I/1XIOPN1HUyIqv+atR3a/YeCBgYyhacGGaUuIYyF7T3Tm7Na1Wc9yTOj
    8K1hlwb479JfGF5FR7UeKrJ8X7koHy1FTWtpFtEHqEUaQvZ52i70RGmMWdKDww6eX3de
    fiWBWy/95AlyAIxdiQoTHp9pyP+wswi6DmrFdX5nOjBr9wDsfRJJfxN3NFW2faYKdkgP
    7IwqUt57ubqIczYvsxW/4KFSorVXAvtWinuit+v8qoQc7XlLfVp5xqm0z07xU+4xI5Ag
    eFYw0TyQ84yrfrd1+z9r6PVp1GoC82lFIcmga+ejOoredIzXcRJGY/4Bow+RO9uH1GZU
    AJNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728853774;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=rKmS070uHKnpPAJ6FiJ+YjLd8iwZ2g9Fnd6v9Uo1Nzs=;
    b=+5YRN7v2r8Cp5MDfc3hIFlQXEBOaKEen/8/DSFBHdpLrqv+b3eNHGr9ZCdkpsWnvSr
    KoiTcGE86+XHRNlycaAQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXG87q6MA1dHIkU4bBBNmkv0kIa54BlKI8="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b009DL9YB7z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 13 Oct 2024 23:09:34 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	vfazio@xes-inc.com,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@iokpp.de>
Subject: [RESENT PATCH v3 0/5] Add multiple FFU modes in mmc-utils based on eMMC specification 6.6.18 for flexible firmware updates
Date: Sun, 13 Oct 2024 23:09:20 +0200
Message-Id: <20241013210925.123632-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

[Resent since the wrong email address]

Following the discussions with Avri at the 2024 ALPSS, I am submitting these patches to
introduce multiple FFU modes, as defined in the eMMC specification 6.6.18.

The new FFU implementation can support diverse vendor requirements and operational conditions.
The key benefits include:

1, The host can select the most appropriate update mode based on device capabilities and
firmware size.
2, The patches ensure that firmware downloads are treated as a single, uninterrupted operation,
preventing partial updates that could compromise device stability.
3, Some new modes keep the device in FFU mode throughout the process, reducing the risk of
premature exits and update failures.

By supporting these modes, we can better accommodate varying firmware sizes and ensure smoother,
more reliable firmware updates across different scenarios.


Summary of Changes:

FFU mode 1:
Uses CMD6 to enter FFU mode, CMD23 to set the block count, CMD25 for multiple-block write, and
CMD6 to exit FFU mode. This mode may exit FFU mode during the download if the firmware size exceeds
the chunk size.

FFU mode 2:
Similar to mode 1, but repeats CMD23+CMD25 for each chunk, ensuring FFU mode is maintained
throughout the firmware download. FFU mode is only exited after the entire firmware has been
successfully downloaded.

FFU mode 3: use CMD25+CMD12 for open-ended multiple-block write
Introduces a method using CMD25 for open-ended multiple-block writes followed by CMD12 to stop
the transmission. This allows for a smoother and more continuous firmware bundle download.

FFU mode 4: use CMD6 and CMD24 for single-block write
A new mode that uses CMD6 to enter FFU mode, CMD24 for single-block writes, and CMD6 to exit FFU
mode after each write cycle. This ensures granular control over each block but may introduce more
frequent mode transitions.

FFU mode 5: use CMD6 and repeated CMD24 sequence
In this mode, CMD6 is used to enter FFU mode, followed by repeated CMD24 single-block writes.
After all firmware data is written, CMD6 is used to exit FFU mode, ensuring an atomic and
uninterrupted download process.


Changelog:

 v1 -- v2:
 	1. Added memset() to clean command structure
 v2 -- V3:
 	1. Refactor patch, and remove ffu dedicated file mmc_ffu.c:w

Bean Huo (5):
  mmc-utils: Refactor common FFU code into functions to support
    additional FFU modes
  mmc-utils: Add FFU mode 2
  mmc-utils: Add new FFU mode using CMD25+CMD12 for  Open-ended write
    download FW
  mmc-utils: Added FFU mode 4 that uses CMD6 and CMD24 for single-block
    firmware download
  mmc-utils: add FFU mode 5 for firmware download using repeated CMD24
    command to download FW bundle

 mmc.1      |  12 ++
 mmc.c      |  20 +++
 mmc.h      |   1 +
 mmc_cmds.c | 389 ++++++++++++++++++++++++++++++++++++-----------------
 mmc_cmds.h |   4 +
 5 files changed, 302 insertions(+), 124 deletions(-)

-- 
2.34.1

