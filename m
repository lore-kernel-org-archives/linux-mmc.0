Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730421487E9
	for <linux-mmc@vger.kernel.org>; Sun, 13 Oct 2024 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853114; cv=pass; b=XeyB1QwHDngM+gqBVgrxmPnfkzv66sgTzjf+Lye9/pCTBkGF+DuWYw4Qtt1XhiRX+OfiapqN1jEPFGVw+Myd5+4M2nnN+rAajNRFDgVxlLTNyA8Iyy3Rq3CH82Gj0RMwM/Vy3ekCdtMGKvgSAA2OBcFeAHmSZ0Hhw5JRmqekKgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853114; c=relaxed/simple;
	bh=7W2RUICh5xCLiaxTF4uJzqzNnbQW/N+myhpEYE2teHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=R9RzAaG/qhb2C28d7CDpA+19NPb+TmzI4zawSlH2mbbUG0MV+FaXF1Pex2IBsjiktaQ9Bw9k31upHLWES0DwOhfR7QQIEmtH4Yn/J83ETlKXKzDa2Oms/3rSjt87wdT1RNVV4Ie0fXcz9yP9hUQMfl7GT8c6y/C2gy0EUnAj5+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=BvqXv0Lf; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=7wYbj8m/; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="BvqXv0Lf";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="7wYbj8m/"
ARC-Seal: i=1; a=rsa-sha256; t=1728853101; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Zy2JRH2y+2iLVoMWUjxLuv8KyvmOOiKOlMdLmvfrRHGSStlVuY6AQRHD5xlMJ32bLH
    lOyHvibWi4ySZAayIM/0F1UvJc7nK9RnNptA+TBxb1evxwNYIXQ+XJBgO0YIP4DHjyDz
    xWAPnKi9HmU3GfMpCRXaJYC6TnJDuJkLEiee5fTjOw3SPVZ3UUhTcPV9TLJVxNjj5nDH
    0qY2rIzBpS1L5qa7XzC1rSmJa31l2RYVLIuRev47EWLKPm7F/VyErM0iKvuYSV4GkDa6
    owT2UM7ztuh4RI2T0BmpCor7QTq8ZImvMfrdzFiuHlop0SXLtuFXlk8zkawgkMYQ8v86
    AcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853101;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4K8BO1w+GEa3OvjRdAVxg6TifKJPlea2Tws8UTT1ENY=;
    b=Ux5fGEMrX+Ntm9B77gaNA0MIci83GlC4c8wU5Is12sjrHYjO8rLDHUmdFOuK5KZEPU
    0zXNGo5Se2aV2cIMRX60e9uC7cMgeyKuKDmAaZK65jwD9DYrOdjptoNk7c/VpIbUzcZe
    gn0xIn+IGgFvrOvRONbeBlt/g8aI6y40hm2XgqvnyI6KZVEJP7ipQLb7S0/FliDmO+ps
    iDLGaTP32goOuFWxE5GvIh8wbh1Qntqmf8bvf9k2DYKv2ASSFQOkmKitlFh9cjZe/khB
    Vx6PuK4cSoBxD5RpHGHn/7RlM5fYDKmYEmQfRrC08X9R8XaLOHPOkQKbGIvLr2NpCdb9
    j0bA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853101;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4K8BO1w+GEa3OvjRdAVxg6TifKJPlea2Tws8UTT1ENY=;
    b=BvqXv0LffXsX4TNvgCWPAG3Cl/rZc1asj9acL/5S71BDLkdnJ6wnJv+RAVt+oGF6Zb
    GmicKTBpaG6wuEh+tmc46MtpIr0zKDe4RTkiPz8iZ/LqPjxP+iD73Mwn7p/DKTOGpPgg
    f1kUSre+ZccoCiLLYRmDV2T6kt0psYvH5uoZ4Kc+N3rfvyFyW1EFwIdWulwvdk9JH9tR
    dEg/PEgPWf8OcUSpZNAUggYtYOq7JhAWSOmxfxBqn+tZvo0XCZXHNWmWfprP0UYF6wo2
    qkmU81hFj/diAbT4tMVJDBebjf3KmyUantocRUCfHcW7z/TuLl5g3RGPrwulVP7mzDQ0
    1mPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728853101;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4K8BO1w+GEa3OvjRdAVxg6TifKJPlea2Tws8UTT1ENY=;
    b=7wYbj8m/Tr+SRgGh8eR1fiJqGrBsZN9u8+lGRsiBN+s8MKCJNx3+XlGWGKH4oCi7IN
    dC5fbCyoLEbIBzTn7ZBg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXG87q6MA1dHIkU4bBBNmkv0kIa54BlKI8="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b009DKwLB75
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 13 Oct 2024 22:58:21 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf,
	hansson@linaro.org,
	vfazio@xes-inc.com,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v3 0/5] Add multiple FFU modes based on eMMC specification 6.6.18 for flexible firmware updates
Date: Sun, 13 Oct 2024 22:58:02 +0200
Message-Id: <20241013205807.121932-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"


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

