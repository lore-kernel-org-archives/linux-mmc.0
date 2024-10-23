Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034361E2606
	for <linux-mmc@vger.kernel.org>; Wed, 23 Oct 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694518; cv=pass; b=Surg+ZjL5ITNnx6FbGZFX2E1TkFHEEQh455CcnMRGCcT2NEcJYgLjiVtE+T8OOedi+CGG8YRyy3nZEJb1+we4YRt3n5OX5XcyJK3bsoQ5tTjm9r+rCyU6mY5USehH0oiGG1NRJKeuZm4J3mC5TgvcA5WQ0hJSNzgxtav9CLJb1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694518; c=relaxed/simple;
	bh=J7Bfl+7hquDBF91RxmHwA6GI4xGbfnC6bhT2hnlxnHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JKaglRez2zD/9hJZ1ciwZbo6kWKRESWpr8HdrYP7XrUYRXCe+MzNiCQDJAxmMfUMBSheQv/mezszPcioMMb06piq2YqARq+FacJWvP0ZuRl0APYJaQXCRrZzk021i2y13r6cdewalDmTsbZiN1txr3c++LjVZMRAXvGIZY0S49w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=o6Kw6JU+; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=gc9LCj28; arc=pass smtp.client-ip=81.169.146.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="o6Kw6JU+";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="gc9LCj28"
ARC-Seal: i=1; a=rsa-sha256; t=1729694329; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LPrJZPvL+5LmWZVZ/vDQN7jcfviV7r3N3/JpE+twdKNQdB41uv+WTBGCD+j3N23rLl
    xMf4+5ab7MeLg+kpM/buyzKoW6AJyzIqp6fOyBitWSz/S/vIV1utnUTXIVrrl/VuKdqX
    XQIo2W336Jbrv8wbF7azHMGT523McThTkEj4tLB8u9Zu0x87ydXkcYEnZHCvLha2vyrd
    gBWV1UOVMwEMa8ui6NCRnj3NJF/FcPoPfUQeG83FUtHZjNRqnXRj09Bhunud/rAN1hGs
    HauBkcTH1vAdqkQ/ohegREHi9U+p8JaljQNlPjUIYMIJdt2vgAtPQJAIpeSlH1HisICL
    M6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729694329;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=2CHizuN/dbjj3UAK+J4sPeWTuQT7n/7DZDpBofVhcm8=;
    b=OBzKdV5LXtenppaxsSUFiX9lUgVgUU6txNK6bhxmQnZyjY+ZzpLOsMWuxkcddbEvDM
    thTHoKQDldNER3N+csahn2BsTZd8WYHva+M2tTAbvzQBs6vR6+BiIwG87fCdVMpKaeCm
    t1RF20o8hla/5+ouFGf/YpOcRiogHnXHwMqogvPbywZvBRTVpyighaDJ22UtVATzl7Ft
    uDavtsWOOeuY6f09nV7vUzeZkFzUSGFze/Aw+XsQYPLS1UOKQfXNZqahQjRoQFhHjM5W
    tYITc35BrF9obzNlGobXCagnyniVerYGllKedPEiKbcYdA4YN4sGw9orBrwhjJvJ3oq0
    6eLQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729694329;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=2CHizuN/dbjj3UAK+J4sPeWTuQT7n/7DZDpBofVhcm8=;
    b=o6Kw6JU+2KVWYDCFnzrYAWoe9MvwKMwbbPySdI8o0Hau2thg10RVq99yRGBbfP9B8Y
    WLghfiYxsUGG5+9HkLyPRiCidbfnUocF7ePua+h7v8jAJOV/FA+6L1gt+Evw9/vOdolQ
    tKYE/9UubFrvU2zxiolehTa2fcVUhP/rPABzA4zvUlTJr/oMpgbQ6X5ZTGdH4Wjch2BZ
    ZraVBHvx0GQsLmditForLHT21XVfp+Hqpdzem712pURnDyCRdWQBmWahg/aDoQPaD6N5
    l/FZ8I0hjSgf8j5Nk7t4Ju+6iWzBFie4iyLgVnF4IXS2AP3YYtwHqXEBslmULMwZoszT
    wluA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729694329;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=2CHizuN/dbjj3UAK+J4sPeWTuQT7n/7DZDpBofVhcm8=;
    b=gc9LCj28gI7cXTiZjG5IkdoUFZyXzuhceIEhEXkY1KHMA8bMRccwrUiuog9ZDeAUYd
    P8IKagmDRGrrh/zpilBA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O2J2YOom0XQaPis+nU/xK"
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209NEcmTm7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 23 Oct 2024 16:38:48 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v4 0/5] Add multiple FFU modes in mmc-utils based on eMMC specification 6.6.18 for flexible firmware updates
Date: Wed, 23 Oct 2024 16:38:34 +0200
Message-Id: <20241023143839.108572-1-beanhuo@iokpp.de>
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
 	1. Refactor patch, and remove ffu dedicated file mmc_ffu.c
 v3 -- v4:
 	1. Incorporated Avri’s comments
	2. Due to "ERROR: in command 'ffu', 'ffu' is ambiguous" when using "mmc ffu", update
	   default FFU mode 'ffu' to 'ffu1'



Bean Huo (5):
  mmc-utils: Refactor common FFU code into functions to support
    additional FFU modes
  mmc-utils: Add FFU mode 2
  mmc-utils: Add new FFU mode using CMD25+CMD12 for Open-ended write
    download FW
  mmc-utils: Add FFU mode 4 that uses CMD6 and CMD24 single-block write
    to download firmware
  mmc-utils: Add FFU mode 5 for firmware download using repeated CMD24
    single-block write command

 mmc.1      |  14 +-
 mmc.c      |  24 ++-
 mmc.h      |   1 +
 mmc_cmds.c | 480 +++++++++++++++++++++++++++++++++++++----------------
 mmc_cmds.h |   6 +-
 5 files changed, 381 insertions(+), 144 deletions(-)

-- 
2.34.1

