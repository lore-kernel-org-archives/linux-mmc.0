Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7CA1925B8
	for <linux-mmc@vger.kernel.org>; Tue,  1 Oct 2024 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815128; cv=pass; b=m7+4ynf6MdZqXnCDEs2yQ/WzMFJSDVq+fUvyUsVOi8bHWZkdN/8Bjx+vUwiZzK3qQaxzaMBq8u1baYgk2AXTVXAp8sN0ZANn/jx1AwtaLJimOJNki23e46pun1rk4kQ3gMHPo8OjIXyO8lCcnKBhx7CXuZHU+kIYMpBRsu8Rjtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815128; c=relaxed/simple;
	bh=NN1uCxL4oLFrkNxAnqe2CtwkGcA21is/x6A1k0z2Iww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=X5nLEXfqHgAqvmBrQ744Oa5SstVB8nV+n3X+FKh3ZLgEkOgZ7nEJEanTCLKlTj7tOBAMcBauh59i2P0Wu+CSJCEKDIBbryFHYLMXql0m7wTyKKdRT3kV9GQ73m3ygKQrrAWn+RRHSTxCvpS0lbqNnL7ECZGhAiANH/1s/Lw8yqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=jo3lavxi; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=PELgMyf1; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="jo3lavxi";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="PELgMyf1"
ARC-Seal: i=1; a=rsa-sha256; t=1727815117; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QzWC/19ofDazhglI8GD2991sJ9W9JvD5cwXCf0I8LLmV/z/MMwfJDBo4KqqKSydluU
    p42m55+MAUSh8CB8TfF4ZgUT6CQ2g9bcriI/4UEhI30VcGYQBF/Sl2IZDX60tE2gIYuT
    lH6+kduzbdh+JqfB/T31B/GJsa/ZNQOl3GS09A3ya8s1Te/ZkVp9sHzl70bhrJaoMJKw
    Q9H41SDKzQuY58/PKldJra8YaetRowE62lXHpBII45mYIbGjH7RP6Bkmv2UXGqGM7re2
    lg8hDoTYEvlOKKZ9zwjiL24EVeME4NolK4wgxzERjjAbH5D8deHT1TgdXAFNnEXh+h61
    dfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727815117;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=EOvoEoI8tl/sFkVKGKczc/LBsgAbH/X8NGeraq3oRaE=;
    b=ez3w81bv5cG0pV/GVrxGH1BFb6oYGTdeFbd641uRXcW0p5Lbi8s3gYPzxh0oHRDYuk
    svo+QQwgGf+04e0C4iG0MizDsJ0Y0ha6TG8PPel4zvuzCw412qGqdXI/9cJ3M57fzxLa
    2NNQiH8s5NE4hjZNUIP/46ew4po9VDMORgLo3JoDfaByb4CvrASh6Xlf1zmF8lfCyxUp
    uoc49qX5ZDbXkJPhlZed1LNvT0fFhnkK14QT4uAe8UvOKyUavckU1pJCYemPC4bd7pyO
    SuKCS5dnC56VVPWTS2rUFxm6xKl5hGDvnYSzk5W/UrIsuP3DlPIb9QPD0n8QhMk32CHH
    sPgg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727815117;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=EOvoEoI8tl/sFkVKGKczc/LBsgAbH/X8NGeraq3oRaE=;
    b=jo3lavxiHnSO/dcEi8iuJBuHG7J+3mnmBLMfyQJb2FPCTv/TORWKbXZg90yTLCHKxM
    gUL2eLF0d+eKtTPr5Ahg8g5PHCt9CY0R9GF++zv3EgbTiLw7eqkk+HDxS5cSIZ3tnf1W
    gOhOp0Fox0s+zMjrDith+m9sLYC9qPX6C+xrngszSQJQxVn/phM81+/u9HOKdbXzwJJu
    q05RCrN2SimAtdbJTA6OiCpXliEmHTvbExC/yN+U1frDAFcJ2X8CBPnv5iuQgc2+dU3Q
    Ed1XU950dvA6C8HU6jLZOr4N+al8KCUBjRu5PEfR5Ujemjm1DBqJ0My+crGV8ftXVzAC
    ISoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727815117;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=EOvoEoI8tl/sFkVKGKczc/LBsgAbH/X8NGeraq3oRaE=;
    b=PELgMyf1ppOPPjtmfsyYln1nzc2bPWFsae1vvl0IhFZKcuIQ8FkBBGRh7vGfx0radm
    6+RC6ctsu0JkekOfdDBw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD06ISTv80p2D11QFwNypsTi9pEHpqtUzGQwQ=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b0091Kcbcde
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 1 Oct 2024 22:38:37 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v1 0/5] Add multiple FFU modes based on eMMC specification 6.6.18 for flexible firmware updates
Date: Tue,  1 Oct 2024 22:38:06 +0200
Message-Id: <20241001203811.26279-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Avri,

Based on our discussion during 2024 ALPSS, here are the patches for eMMC FFU.

This patch series introduces several new FFU modes, as outlined in the eMMC specification 6.6.18,
to enhance the flexibility and reliability of firmware downloads to eMMC devices in the filed.

The purpose of these patches is to offer different FFU modes to compatible with different vendors,
allowing for various command sequences to optimize for different operational needs, ensuring both
atomicity and smoothness of firmware updates. These additional FFU modes provide multiple options
for performing firmware updates under different circumstances:

1, The host can choose between different update strategies depending on the device’s capabilities
and the size of the firmware bundle.
2, Ensuring that firmware downloads are treated as a single operation, preventing partial updates
that could leave the device in an unstable state.
3, Some modes are designed to keep the device in FFU mode throughout the entire process, minimizing
the risk of premature exits or failures during updates.

By supporting these modes, we aim to enhance the robustness and flexibility of the FFU process,
accommodating a wider range of firmware sizes and ensuring smoother, more reliable FFU in the field.


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
    repeated CMD24 commands

 Makefile   |   1 +
 mmc.c      |  14 +-
 mmc.h      |   1 +
 mmc_cmds.c | 274 --------------------------------------
 mmc_cmds.h |  52 ++++++++
 mmc_ffu.c  | 385 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 449 insertions(+), 278 deletions(-)
 create mode 100644 mmc_ffu.c

-- 
2.34.1

