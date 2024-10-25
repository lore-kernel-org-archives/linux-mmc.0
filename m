Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833720C334
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888516; cv=pass; b=UONqGyAfBJF1CVKscBoqfGwPctMZZyoTPJcoDPL/bd6wzLO4MGFAVY2BeGWs4DM9+nIybyaQcyaYZmBU1iz3XiGB/bkEcpWXmkVVPqEqEZsbn+9F6ALMudwCnh8IFYLJH3QhF8xOlUvHuwBVw+v321xhKbhJt8lyJo/laXtf9+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888516; c=relaxed/simple;
	bh=902BSlFkpPs3DWVgRAlKvAb9ywSS+wuc6kYgU0j5UV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KwsV/jrqI/9rR8+Tn2fV4m0Ku+yCSoUWFvfcCZW8JcBCQ+FW+pTuq5IbBeI+WM+fWwdxREBnif97QtW8O1R8KgnTJoLHjHTnIfmyw9ukFWRMNHjJ5loOX67CIMQ6FpRvXDfZMsweKEweqXlARCLGLeJloS5AmjP6FjCMCCB8DXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=DvbQe1jE; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=aEQSsNGt; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="DvbQe1jE";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="aEQSsNGt"
ARC-Seal: i=1; a=rsa-sha256; t=1729888502; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=M6XrWMSL3AZzVzHYWgzTIvsoA0AXfMMSYskgaWouyazPk2YBu7ssVGaB0TuPDL4gJw
    QNHf46D8vgB9uWTeve41Nz0JBitfjvh521kK4e9YC0Z5zOBINZOWaP40hj6yn6oVVHg2
    cVefSV7PJFXhYL11r/rSkrMJ6feTIbuPx3msrAU2dLZSPDfLTOeM4C+3aApNR7e1/bsS
    KN3Y58egYZ2xjYzfnTzHNrK9H2/cpX0dPln407YGLce9AwLBq89WVeGzdKvAsYPbdps/
    Kl4Vf1kAHPizTtvTFOOB1hykiqCRyCVV04wcsnNPpRTd+nC14a7g9jr0K66/vG/oVh9y
    8OUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729888502;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=qwQv3+sgXMO/u1Ttkn4uzx59n3+6Ujkyrmar3HK4/Zs=;
    b=kb1noO+vhdBcfztjvkJlt/2f4Tv0UBjmSgVlKtRFWwOrRQ5QBXuijMBKLwim/rnr11
    b3vq0tRdhe6Ze25KlyYNgkTXPcRZnfWXG/9d4m7nRUX9rjg1+ylkD9kkMbmoUaG8Uoq5
    hfNo4pwdk3gRjXNs8aTOcgd7gpcHBBXZQ+ZU9W6DOvPRSSYQ50Z8aC/X9d5VyZQKl17k
    iO4P8PS8kaIEpIIXIbzXtbx3euGIszX6NEFEkwCVfTC/6zY9uDWPqRgeCKOe9UcWF0zW
    UechMsDu6i4fpBrmow865lPK0CSGXH5nJLORzg/Tt2+GEqhsiHS4w0DaqY159o/1n2Bi
    s1Ng==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729888502;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=qwQv3+sgXMO/u1Ttkn4uzx59n3+6Ujkyrmar3HK4/Zs=;
    b=DvbQe1jEWOQym3H4oEY7Yq4IsL07S5N81m/pyCI0xW4oEbjUWjeV0jEyumCHE8GvAS
    mr9e5kki6/InCisZw61pllyAPMciCeZkdrVVEJoyEt3PcNJIe9eOEgKQNmC2cFR4CVqd
    1/l0/NDcCqC0ZMN0MY3D67y39G6wCcENSBesgPlp8tazRTwHeRFpHG2oxcdXeajRk7iZ
    d/2+gpvUL9WA22m2329y9JJ0UdxLwOuyPI9KasV5XP02V+yaT+WMHgqNMFHydBSk0DXz
    FYo9qplm3+Mv0kNow7Ys6w5y3+ELGa0SDZkQfbQ6ZWabWp3jmstjNkOsv9Te5/0pJQ22
    E80A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729888502;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=qwQv3+sgXMO/u1Ttkn4uzx59n3+6Ujkyrmar3HK4/Zs=;
    b=aEQSsNGtfVRPgI58GWnum4cL2tI1wLaYDWzvubMVGDJ+ryv0Fsq34+N+BnqGGqLelj
    s++uY4t5vqqKyNgksXCw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXGo7S6YVZbGYm2ZHbmjWFWcm6Nbb9lHw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209PKZ2bfc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Oct 2024 22:35:02 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v6 0/5] Add multiple FFU modes based on eMMC specification 6.6.18 for flexible firmware updates
Date: Fri, 25 Oct 2024 22:34:49 +0200
Message-Id: <20241025203454.162710-1-beanhuo@iokpp.de>
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
v5 -- v6:
	1. Fix a typo in patch [4/5] commit subject

Bean Huo (5):
  mmc-utils: Refactor common FFU code into functions to support
    additional FFU modes
  mmc-utils: Add FFU optional mode 1
  mmc-utils: Add FFU optional mode 2 using CMD25+CMD12 for Open-ended
    write download FW
  mmc-utils: Add FFU optional mode 3 that uses CMD6 and CMD24
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

