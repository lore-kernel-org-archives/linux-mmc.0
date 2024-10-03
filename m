Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858619F134
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980927; cv=pass; b=ag+L4PXSzXUSZKgpamJarPAREq7Z/oRNvgtgMOxT6AhgBhXZmB4GgEiDj53s+TZzaa4NbI2kqdlgkfvJw/0IZZwPHyvWOfmMtrF9NZJpnNb7WoS6H7Yv3FhOnpkZYs5E9EcxOPHAPleSE91gqUQ3LwE/GNYYxHbtA7hyjl00OzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980927; c=relaxed/simple;
	bh=x0rmTLgRGG9sI8xO2f3+p5YonFanHENWafEHHqSmqnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FevAKSlkK4Laa0MRQzB1a0bzSmlkvI0zPAxoGG2xFawPYSLvSsVy+Sy+GA+dVh5+gqgsifmeJptibBhb8l0AVtopHoKVvoIiw4rrom+7XVF6j6KH7RZDvM4elwPXQR5Ab9tEoEbEh3ERuJUC6uH1x1TTLW7JPHw5wzVsnEeU7Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=p9I9yW78; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=z2+XXwjY; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="p9I9yW78";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="z2+XXwjY"
ARC-Seal: i=1; a=rsa-sha256; t=1727980741; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=L5rJUMXpxG977Snalh5ieIIUKXkSZoMWJIFyLZdLC8nVCbZXjcDRq97+XeDGTYab/D
    VIsWoxqmKcLXmbfhp0SgVhKZMtwKC6XWP/HwnmVbH5zN9bWzN21BGHxBJYW8ZhX6hp6s
    15kXgaYzLNDktD6uxjuxxeho7X/0ELdnNQxsZsLBzk68hibl4/UEICH9o/t4WZyelOYY
    DhwHH6OM9KXDbm0pQonsoWpaL0teSMPC6rIxLgO5G+1NFYa/Uuro8KSX+Fi1fBUNtPDL
    OJHBgfnT41Or3yxzBDn9c2A7KISRoQ11YReys8ZD30sTpZzzkZDny8L/VbEMNUWG1WV3
    8vmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727980741;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7d1CM8HVO8AgW+O3KTNFkHCUYiIBH2UbIGSKRU9cXpI=;
    b=OUO/8WVOB9aBLifBgZW4mwP4g9rZLv5lDIUClywqY9AutRO0O7QMIwKu/0R+Oi+Lth
    orTdLlTiE4DGBDrL/htLmznLAOuquVjSdjBmLmE6UEsbc1ZEzWZBIa5MkS2wddcpdnxU
    hNTl70Mls2ZgE4GPRhObbsam/h6L+R3YdGKIJ3Ciu+2Z4lgP7LvJDiIqgackV4DTiPJT
    xV8RNp2n51RDxIIt/yL6+lh5ZOvxapgwJKkqrimguIJau81uym4xo4EjONMFXA56WPY/
    qNev97dpSma0FFWjsbN0d5n21P48po/S5zj3YeGpBXAQSfMSlIugx+71fZknQYtl5nAH
    PgOw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727980741;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7d1CM8HVO8AgW+O3KTNFkHCUYiIBH2UbIGSKRU9cXpI=;
    b=p9I9yW78KXtJtg20totJiNbcJmhde5nA6OnTSy/nWAQfQfvgHkC7GKDKos4hY/3Cr4
    BDe/UAGDhzkQiF+EnR/K2iFiVH5aWRjPfJDsOcEExe0daBlKo2xoMtfw+S8OB17O6TwC
    cOAW6uK9aBDw4VwI8KDS+zcGTXgrwxLghlDqlk5o6Gx9e9zheqPtVGzFVy3LW1Ktk+22
    oucTnwRKJT+8E8/fHPHCyXtvpGd2Y2Wy1yeVlxihZ9lxheDBLUvlAUSeN78S6rztX3cD
    3/oGOLkDJhEYJtUbNuwNg5jO8w+8iiIJxtnFaujqqkdqF5VKZv1KC3fdypTEs3ATn/x/
    fxQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727980741;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7d1CM8HVO8AgW+O3KTNFkHCUYiIBH2UbIGSKRU9cXpI=;
    b=z2+XXwjYgBPFXTc+MOUs4cia0weJDIUBZt8ynrBTOaCdOVq7Yt58sD30twlnhh6S5g
    ZkaW56B5Q37AiwhHZ6Bw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD06ISTu50pjmwgQ1wz9b7T+Mhx2Sk00RyG5Tc="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b0093Id1iL6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 3 Oct 2024 20:39:01 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v2 0/5] Add multiple FFU modes based on eMMC specification 6.6.18 for flexible firmware updates
Date: Thu,  3 Oct 2024 20:38:43 +0200
Message-Id: <20241003183848.58626-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Hi Avri, Ulf

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

Kind regards,
Bean

Bean Huo (5):
  mmc_utils: Extract FFU code to mmc_ffu.c for future FFU mode expansion
  mmc-utils: Add FFU mode 2
  mmc-utils: Add new FFU mode using CMD25+CMD12 for Open-ended write
    download FW
  mmc-utils: Added FFU mode 4 that uses CMD6 and CMD24 for single-block
    firmware download
  mmc-utils: add FFU mode 5 for firmware download using CMD6 and
    repeated CMD24 command

 Makefile   |   1 +
 mmc.c      |  14 +-
 mmc.h      |   1 +
 mmc_cmds.c | 274 -------------------------------------
 mmc_cmds.h |  52 +++++++
 mmc_ffu.c  | 392 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 456 insertions(+), 278 deletions(-)
 create mode 100644 mmc_ffu.c

-- 
2.34.1

