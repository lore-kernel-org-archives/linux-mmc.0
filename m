Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.73.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793073273;
	b=QE4OpqAKa0HK0rL24rLPmwtCQp++ApdcfdbSY0T2F+VTsaIegVbIAj+kK6CiC4bZdQKd
	 razaJxJZrW3SofHsmqekzRD4bpFVdzT15pMnvufkx3uMSNHmxK18Mi/57ojKB/JGsBvi7
	 YPul+4djzpMdTacu6F5lL5wlqpk+xtzTMQkxk1LlBMEvD7mDDhQUHblHjvdsA3Sp2Fk1s
	 IT9z7F7jkf2T7yv5XXqN7IgjxrH1GOqn99Hfrnul4FKWFhiTPUU33psYcxrIyVDI0x++b
	 N3Ir9ilOriaVj0WVGyZCJy+VFraWQpP5dJHF3criFS4/OrHO19XiLErjBpl/WjmHZZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793073273;
	h=DMARC-Filter:Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 mail-alias-created-date:Received:From:Subject:To:Cc:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Info-Out:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-JNJ;
	bh=c557NJspcrYp97wcV3FzkxycYN4AmMz1y8uOKeLXX9c=;
	b=Rqx/0bIg7MLGZOg4E8AOv5g4IC/ZaYJxUDTaeHDn3pru4oFDvy7NyEwbexWEhBfonE4a
	 4AI3A3nvNrTMB1B8ThtYR/G87JEqoo8pk2sQHSQl8RbGtxT24QkPm27p2FZZHRbucJMlj
	 xwUfbMwM1AinZdBlVjrWVxiH8tAXBirt+oKoZ1MMnGUM6Txg/VOz4jNE7k2zprAjPGiBz
	 o/qAQZtRiimLaL35lIoBgXEafMe5RbnDpZiyn7G8H2HGQF+8R8CKBBGy40R7sAO4CcAOn
	 W0/QAUyQcqbih2iBD5VzngjIaOXXdPiLb4DxA14HbaNQXx+4cCGkwXLrGZOf4OsSxqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=manyhobbies.com;
	spf=pass smtp.mailfrom=manyhobbies.com;
	dkim=pass header.d=manyhobbies.com header.i=@manyhobbies.com header.a=rsa-sha256 header.s=sig1 header.b=aJh0AGum;
	arc=none smtp.remote-ip=57.103.73.218
Received: from outbound.ms.icloud.com (ms-2001i-snip4-7.eps.apple.com [57.103.73.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F0606A31E
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 03:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 684F0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manyhobbies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manyhobbies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=manyhobbies.com header.i=@manyhobbies.com header.a=rsa-sha256 header.s=sig1 header.b=aJh0AGum
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-5 (Postfix) with ESMTPS id 288F518000AA;
	Tue, 27 Oct 2026 03:54:28 +0000 (UTC)
X-ICL-RepId: 01a17b7e-c94a-7c5d-b7c2-55b64c5de973
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAUMGWQZeD04dXwVcEhVdRUcMWkVWH3kVUgNOA10SWxFWHhkIXR0ZHldQWgpcCVEXUQ9eDkFeWhdeTUUID0kZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1UGV0UXwRQElAdQENUBF9QVBFXUAtaBUkKSAReBlkDQA1WAFQPXQFeCEoAWgVTA0QITgBZAFkKRAFPBl93BlMeQBBcD1UCVwMXG1wACUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manyhobbies.com; s=sig1; t=1793073271; x=1824609271; bh=c557NJspcrYp97wcV3FzkxycYN4AmMz1y8uOKeLXX9c=; h=From:Subject:To:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=aJh0AGumjEqUA82HLgydg7bSQii8pFGQGAywdpmcFB++chslRvqswtVMzE5ZazNKcUGMRGzKtPZJS8794b+0TYfvdYOfTWqkLt29D/uZomQOMi4t+PHKAfClCJ9pVlsOBlyRfzDFpXSGGVsJUvEtDQLyc28ZuQyAXdyP43ZXY1Inz/30xp8guqug6SQAg5ds8ARhTWj5L6oXT3TxqotmXq1crgTXnhtJw0CblRC92iU+shQ9Husp2ECB8TGQ3B/L+RsftGhY18oE6we4wdWnkoSFD654T7/J13iA48f1FNOiln3O495aMSRMMByoxB3YAHAkbO9dYgQ5T2X9VMhVvg==
mail-alias-created-date: 1780273699991
Received: from claude-agent.manyhobbies.internal (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-5 (Postfix) with ESMTPSA id 26068180009A;
	Tue, 27 Oct 2026 03:54:28 +0000 (UTC)
From: Tam Do <tam.do@manyhobbies.com>
Subject: [PATCH] mmc: sunxi: reset the controller after an update-clock
 timeout
To: Ulf Hansson <ulfh@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
    Jernej Skrabec <jernej.skrabec@gmail.com>,
    Samuel Holland <samuel@sholland.org>,
    linux-mmc@vger.kernel.org,
    linux-sunxi@lists.linux.dev,
    linux-arm-kernel@lists.infradead.org,
    linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2026 03:52:01 +0000
Message-ID: <179307312104.39863.12372814163472848752@manyhobbies.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=fbugCkQF c=1 sm=1 tr=0 ts=6ae02076
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=w2OPf45SAAAA:8
 a=OBswR2QUZwThbbyFsH0A:9 a=QEXdDO2ut3YA:10 a=-iXIJKm6ftRzmWoHelNS:22
X-Proofpoint-GUID: y2SgpGtdZ7vHdcPuD7Ypjoc6D-Sv23Sj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxNSBTYWx0ZWRfX6NLdvTed6MJk
 NDt9+8d0rQtPMNEI7W0Sgwrwc5t34pOkSvmarHPDHtAhv3/NplmE+OYdB0qFxLm6lN3CuyCeQB/
 BEr+gIT7FTo5/RmL7XAdxxnQA5wf2cIgL17KxQ/991O1rDI8PodIbltZ/jotFG2/umWdKCAgO5X
 LGK5r8G5VJsf9HisuUcikkDlVONrJ2fe0ACUD6RrADoZPRXs7yZsHZAn66kAhRau7pa9gtiYtYZ
 LtJc0kxK03QFHId6WWBlNijwmYfJOykTq/+dJScH+rDAGKucc5UqKruTuKTp4ZQDrPhIF8NGchF
 TrRkbvLAcYEBoB4Id2EHjfrmSw1/RwbQ5tX7gKcuXHvLss9AMGP+atvsvXYdp4=
X-Proofpoint-ORIG-GUID: y2SgpGtdZ7vHdcPuD7Ypjoc6D-Sv23Sj
X-JNJ: AAAAAAAB97Wku43oW0onLL0nsnuVzNu/wNnoSw2Lfvo1qg77wELWKGEOx6s/vTlMnrJy1v1rTIZ++H0LHfbQEvshtbpLg80viBL3MgEw9ypfH3ljJIbppdVgA/Fog/xP0A9MocRTnVlDRBQpwYD/+0IFgai8LiK4o/RNfYpBsgUwJdgK//KsqYoOvJhQ758Sn4ksBXAalCi2OYMuetJRVetvR9qaaNCGAPT8OHhXZ9DxvNMwOpuBZyuJxppSwoI6C28PPZm4R1PPSbb0wvf5/Mp6IlA2ggC4XPsRzc3qe9bFYj3+ZduQetG7/pP1FSwbyeDKp0tGjJkOnA2Lo+cU8o0hNh1MjWDB2v22l6JgbYQVd1ypsg+qlsLL9v/ZvEwxCTyCP7RcmGud8QgI8u6JkX5iAkc2UlR+nKfi+3UdI6mrdaQOTXvNpkC1lepH2Ikdgxbbh3zO1aymZQXK/n8lzJR44sgEQyGpRdPb8j2J84brmSedvC7P24qrKrPiwRZoalpw6EVqx+hbMxSwsRwmNWlCk3mQwU0BFotv+IvvRjmfmbiPzP5crWfXHAp5Dl9BzHY7YQD06WKHSvUXwm+JDXBq6RnY1gkbNiN5HJ/0aKRA0hX82FvRBhbrJsC3jeEdY2thvPN5MlAA+Cp6kUNXgYyrw3mk1RRnNFifNcxZhLFsMbDlmpVfLR7rN7X0tNPmjYbPKGo0h7IhZuDZb3GY61ESb6+O106ySIuZooKp7L1swTQ7UmHFfskNhQFJb81vNqODACe6ocjp+tjz/R3HPwe0mEhAkKu0LiMzZfe/o/7iAHBDYkWMbugTtcz+Te8t6uJvwOc3LAAXMoxNU2rI19bm2P1qtzEhz+X4jRH3fiMtRfUgNRb96sdUDr1zHTpAKZ+M9Ma5g2gbg4RYuml6e6wfRgxq3YLZwQcX5YGeliDixu+6pTVrNfK0885TG/xxwPJQdVy1eP77R4IXBMbLj0vqajXYYu7
 +vinsDdtAIdgHFCyqTOCA70Qy3VTY1lvl57b0LU0lwwT8zLVXRPwpNZeLEzN+mXf8rrQdHMgFdhD3fxUgFNw5Fu5Qr/IwvdmjyJvsJctIJTSbQGAfafBM9rs8R94yn2rgR4ORR2C1w+FRoZv32tscoaXhycEvYsst1HAtJqrVERdFmUeSfXN6Xvlm8D/X+ynHchM9lGTywhlFSCMaszZR/2ciaL1Op/3w0PaDEjyDOh6lbw97TR4fxDUdqAA70/qZsENOLcL9R+LCbk+jKRyg75NiN85pTaId9K+eq1yXd3Xeuh1dv5aO3RLNBzZNg0D0QJWbaZAeKWmC2RwU/7MFZ+ScKEbqzjz//yFSMpIBO+tcNZYt

If the clock-update command times out it stays pending in the
controller, and every later clock update times out as well, so the
card cannot be initialised until the next probe.

This happens on an R16 board whose SDIO Wi-Fi holds DAT0 busy while
its supply comes up during the first clock update.

Reset the controller on timeout so the next attempt can succeed.

Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Tam Do <tam.do@manyhobbies.com>
---
 drivers/mmc/host/sunxi-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index fe4c0f6..439cfa4 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -688,6 +688,7 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 
 	if (rval & SDXC_START) {
 		dev_err(mmc_dev(host->mmc), "fatal err update clk timeout\n");
+		sunxi_mmc_init_host(host);
 		return -EIO;
 	}
 
-- 
2.39.5

