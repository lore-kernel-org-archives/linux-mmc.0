Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F520EA32
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887735; cv=pass; b=AkTbI+bnVxarFQNe2BalIf7P5sLvyYgkso2uwi/JXZZTfnPbGLs1KzSUBULqBi7KjsLZ/2yQfOafiB4bHo5G9PgScfTMLh3BqaaPQvTRneOrA80kCUq7Us7NJ5p6k+y5atovJlUqKCjh52Jcb5g5IiqxPKQZoOYtHXXFyBdT5nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887735; c=relaxed/simple;
	bh=A8TDF7Ng/WXc23wTlCMeRGD+bsrNWdMZq7tZVwx9vnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sm4wBvf5bQvkuhjFT5ow2SW4PRxcDBqJtHRcufrCeycpZzjlycsbdPN0dU6PSkL6RkyebZGMYkmMrgsRV4jR7DIPPrEwsGm/DbXOxvFmEw2P0tw719SIqP1gLuLPQvE0EU0BoNL2ZRvqDloE2PLVWyOLwhk25DxRrKRY6zPt67M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=jM3p2dcc; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=nwCp2wcJ; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="jM3p2dcc";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="nwCp2wcJ"
ARC-Seal: i=1; a=rsa-sha256; t=1729887719; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ME9mC3D1pk913SHa5P6zNCbRimxkSDqXonVV5vchPZre5X+9TZKz8KLUN4pYOocxRF
    7KzbRTlKGXeD9/9EOdmqzOnq0d7IvhnCSgt5+7acbH0Rm9sZhaAOzQdKccQgNMj+Vklu
    XZesfJXqR9A0/yiBpl6ngo3kPpMLt0pvtlxz9aOykDb/9cgsPyI6FsImHURPhZTbo5T1
    6G4hJhtMIEmBNxAQR9DLMXUbxP6zwesdgmK0kTU/vNvkEM3D4/s9WJpcCD3XEnwn1730
    Fle7DAILfCH5ruhXjnMpoBqns8fTV4oVT6cqm6h7Lm4q/1FF2UxQGiMw7qmYJbxJRBdp
    pn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7q/PVRVcgB4jTlSCbHCYuihWp6ROLksyJlKDQNJnPT4=;
    b=CWRGVqmNMa9srXYtV/NYjpvqugs2/rWdbCx1L2ehInDJ+grSLwwFpSWapuIzuRI9cY
    R0mYXOrxu20MHnya+xZyON/D179zcGx0MSGGjSBsvFpwNudWP7KLo0+9quA2HgdMOO4l
    GZIZv6L5xwyV0Wx//a+FC7DGX/dU8e8klQd3Q5IPFSftBXu0ea4yrVJ/4nRuhCxJldK2
    6oqfgDtZHAhKWSCgr8cgAm87iO5wDQd/VM8mWAk2vtIV4DhNtMiQ+v/v1w7cXKX8Sl/0
    19L2nRbaYqOqgq6pI9+215FOt6FczQjh4o3+wDnloYe3TxqQWUjM1cSTs/DgHupBRyXk
    sxuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7q/PVRVcgB4jTlSCbHCYuihWp6ROLksyJlKDQNJnPT4=;
    b=jM3p2dcc5Eeaa2hNIDxffKIgoQYSjSzhKYigkwPDdY/GhYaBhaLNgnNn+L9JrJKp5v
    nB9KMbptObVq4xseiiNXatu+wDBnwQqj4pkgNfTVMIxGPGS0Spp+lV4lUE5FTsNQIuD9
    l8aHhmqXUbtv0XCYH1rrGF3xppvd2Nol9WHANbA3hnn69AZRstnJgRJUGwhyOYlPJ+9a
    wcZsQdgTg1yQeN4fKT9MM5R1ce0+6PcI8jv4hgZ83FdJFggphVDDYpx3DIUJ29ba3XhG
    bx3/f7PqVJdqgb8TMnXr37qU29SBYM34simSIBDa/qhVnzUgIcZSx/4hSHMCN85pbwei
    bxxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7q/PVRVcgB4jTlSCbHCYuihWp6ROLksyJlKDQNJnPT4=;
    b=nwCp2wcJs0MFrwOF80EENfgSqWg30VV7o04UIywab871vlrGqYh4wXkzpwspJ6w57p
    0kTi5NCS4KzHzbv5HsAQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXGo7S6YVZbGYm2ZHbmjWFWcm6Nbb9lHw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209PKLwbev
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Oct 2024 22:21:58 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v5 0/5] Add multiple FFU modes based on eMMC specification 6.6.18 for flexible firmware updates
Date: Fri, 25 Oct 2024 22:21:43 +0200
Message-Id: <20241025202148.161586-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Default FFU mode: "mmc ffu"
Uses CMD6 to enter FFU mode, CMD23 to set the block count, CMD25 for multiple-block write, and
CMD6 to exit FFU mode. This mode may exit FFU mode during the download if the firmware size exceeds
the chunk size.

Optional FFU mode 1:
Similar to default FFU mode, but repeats CMD23+CMD25 for each chunk, ensuring FFU mode is maintained
throughout the firmware download. FFU mode is only exited after the entire firmware has been
successfully downloaded.

Optional FFU mode 2: use CMD25+CMD12 for open-ended multiple-block write
Introduces a method using CMD25 for open-ended multiple-block writes followed by CMD12 to stop
the transmission. This allows for a smoother and more continuous firmware bundle download.

Optional FFU mode 3: use CMD6 and CMD24 for single-block write
A new mode that uses CMD6 to enter FFU mode, CMD24 for single-block writes, and CMD6 to exit FFU
mode after each write cycle. This ensures granular control over each block but may introduce more
frequent mode transitions.

Optional FFU mode 4: use CMD6 and repeated CMD24 sequence
In this mode, CMD6 is used to enter FFU mode, followed by repeated CMD24 single-block writes.
After all firmware data is written, CMD6 is used to exit FFU mode, ensuring an atomic and
uninterrupted download process.


Changelog:

 v1 -- v2:
 	1. Added memset() to clean command structure
 v2 -- V3:
 	1. Refactor patch, and remove ffu dedicated file mmc_ffu.c
 v3 -- v4:
 	1. Incorporated Avri’s comments
	2. Due to "ERROR: in command 'ffu', 'ffu' is ambiguous" when using "mmc ffu", update
	   default FFU mode 'ffu' to 'ffu1'
v4 -- v5:
	1. Retain the default FFU mode as 'ffu' and rename the other FFU modes to 'opt_ffux' for consistency.


Bean Huo (5):
  mmc-utils: Refactor common FFU code into functions to support
    additional FFU modes
  mmc-utils: Add FFU optional mode 1
  mmc-utils: Add FFU optional mode 2 using CMD25+CMD12 for Open-ended
    write download FW
  mmc-utils: Add FFU optional mode 4 that uses CMD6 and CMD24
    single-block write to download firmware
  mmc-utils: Add FFU optional mode 4 for firmware download using
    repeated CMD24 single-block write command

 mmc.1      |  12 ++
 mmc.c      |  20 +++
 mmc.h      |   1 +
 mmc_cmds.c | 492 ++++++++++++++++++++++++++++++++++++++---------------
 mmc_cmds.h |   4 +
 5 files changed, 389 insertions(+), 140 deletions(-)

-- 
2.34.1

