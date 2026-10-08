Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251D9305692
	for <linux-mmc@vger.kernel.org>; Thu,  8 Oct 2026 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493334; cv=none; b=SI+QwUdi8HDV/PHUFWcE206UeasAjt0QJ9PNeVag+LDbHheqQJlaxh3G33wZ2b9GJCxbnrlIVIiohvqQ4J1wREPJ7taltPwG/XQOpuh3M7Tb9FQtERuc/lxoaIPj9M3B8ECDmfaW2jDDummhYkCgl52GmQuzXn4/TZqZ3pYujLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493334; c=relaxed/simple;
	bh=zzbL2DxW3HgIFLpNuRMEEytronEcId7gBv0pJACaAe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PtslJuQavBsN6kB2Is3uIVomlt5YkQI06Jl6oCQhv4KOXjMxQP+JnPoq95ZPFkjPha/RIl/fGzMtFNKkywSbTUJht6G/2FbBG7Fglbu/Fr0E1FmjaApO4qpk7ofOD7Y8+ZRTl+FLvJX6KGuYQLe2mrm75JirXanJ+XvdgNjJr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezsdlgTV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezsdlgTV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98D86C2BCF7;
	Thu,  8 Oct 2026 21:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791493333;
	bh=zzbL2DxW3HgIFLpNuRMEEytronEcId7gBv0pJACaAe4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ezsdlgTVpz1cSGyAo0HwUsBEz0A7M2BkgvWBjK8Pq48fuZCBWerWN5FZwV5Z6lg2Q
	 oEG7Ne2QxyyoLENYLvqBJcf29ZO075dZtbXM0b/5Bj9uHi9OPndW8Ln32w/nJOeUhq
	 8iX4yZTECo3fZpdoVdMB5NcyMbc88kZWkyKgzFx727FR8CQt/FYXWlLQDDk4Dd6+4t
	 pxeJ9j1WuDFdJFr+PSMj1tWcEX3gkV8bOQ4+dlL5GKWzE0mJC4eNIzUBSsi69D6esK
	 ZedLgRv45tlPgSNpEayjeSl3+P6n8VHoG6HVjtYi2bTF9Ua5cbE9mN7o70rDkuoQjE
	 +yxQNyHGNfj1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E98ACA6017;
	Thu,  8 Oct 2026 21:02:13 +0000 (UTC)
From: Sebastien Bacher via B4 Relay <devnull+sebastien.bacher.canonical.com@kernel.org>
Date: Thu, 08 Oct 2026 23:02:09 +0200
Subject: [PATCH] mmc-utils: Use an unsigned byte counter in DO_IO()
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-do-io-unsigned-counter-v1-1-744fa81f0a0a@canonical.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBuwIomuEi1MR5vNGFoRSHdPW
 r7F/wUyJaYMc1Mg0c2Zo1R0bQN2NxII2VVDr3rdKTWhi8gRL8kchBzaeMlJCUc9GT1shvxoocZ
 HIs/PP17W9/0AC3MUt2gAAAA=
X-Change-ID: 20261008-do-io-unsigned-counter-568a63baef5c
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org, Sebastien Bacher <seb128@ubuntu.com>, 
 Sebastien Bacher <sebastien.bacher@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342;
 i=sebastien.bacher@canonical.com; h=from:subject:message-id;
 bh=RFqFYmhSpK7v33WRCuY5MzgPPz11wJINJ0qqSHLpdqs=;
 b=owEBbQKS/ZANAwAIAVlh/b6cYZgJAcsmYgBqyATU53VOOz1SAgihPexDQBAm8rofepz4y6YoG
 IPTopO29aaJAjMEAAEIAB0WIQSS/k+LQMrcTszWDB9ZYf2+nGGYCQUCasgE1AAKCRBZYf2+nGGY
 CR91EACKSpeNuKDwBmMwmrxupBJM34CQXXXyCBpHut47MmfU5YcrMDPTBmwoEffktZ32Jf2EDLP
 C4+xuV4AVZOfsdVDxTR9tNPa7hZAS9nBynrfBqHeUwCl12T5ACTBMrUPq7bJjPsSBJC6NpFS/F9
 uMHkLRbpzcpEmTv4dg4UVrjx1ZdNqrZ2ENEanesswr5fGMjYnUV1wa8idoI5H04TqtUzXhOhHh4
 xpoBJLftO67c4D3OJXdH5ms1rFNsdlgWHJlnjmNPmdS9TF2n4fdwqsjI3TEmCx56Y2jrPRMErP1
 mJyg8AN1JdNf6UKEw0KJn8v59hnxkSKBcwWPtmkqeER7sF46pBP1kRw+47kkWA6b4jbZ6MQtuq4
 zM//q85ihfTLvXB9yzepZ0Yns297Whm5lz355SthxYD4daPeVzbQJ2CsVlbUqhOz98JUCf/sFia
 Aqq4UJzpdQ+FNX9fAV5kkIao0fFIKwT7dwT442/zlJqgipfZ3UnO/FZsFOyDnsMyx+uk9tp/r17
 L3tuKKpNfspNTFwjYT7UZZxrgArw/0+U3K44ipzLfi3eL+v8KuXmgZcYGN+pglT15H99Npn1089
 HMT5jetTIm4rMiA4SdcqGUTCAbIGClmSYJ/EuFJV+01XuEIdnjNblxoybKj94+d5zXJnuw4SGbQ
 RoDaoQ8WiLYExPg==
X-Developer-Key: i=sebastien.bacher@canonical.com; a=openpgp;
 fpr=92FE4F8B40CADC4ECCD60C1F5961FDBE9C619809
X-Endpoint-Received: by B4 Relay for sebastien.bacher@canonical.com/default
 with auth_id=1136
X-Original-From: Sebastien Bacher <sebastien.bacher@canonical.com>
Reply-To: sebastien.bacher@canonical.com

From: Sebastien Bacher <seb128@ubuntu.com>

DO_IO() tracks the number of bytes already transferred in a signed
ssize_t, which is also used to report errors. When building with
_FORTIFY_SOURCE=3 and LTO, gcc 15 can't prove that "nbyte - ret" stays
within the destination buffer, and the build fails on the RPMB data read
in do_rpmb_write_block():

  In function 'read',
      inlined from 'do_rpmb_write_block' at mmc_cmds.c:...
  bits/unistd.h:32:10: error: '__read_alias' writing 484 or more bytes
  into a region of size 256 overflows the destination
  [-Werror=stringop-overflow=]

The loop can't actually overflow, so this is a false positive. Track the
progress with a size_t, which can't go negative inside the loop, and only
convert to the ssize_t return value at the end. The behaviour is
unchanged: EINTR is retried, other errors return -1, and EOF returns the
short count.

This is the default hardening configuration on Ubuntu, so mmc-utils
currently fails to build there.

Signed-off-by: Sebastien Bacher <seb128@ubuntu.com>
---
Signed-off-by: Sebastien Bacher <sebastien.bacher@canonical.com>
---
 mmc_cmds.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 2d9069f..8e21a25 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2207,18 +2207,21 @@ int do_sanitize(int nargs, char **argv)
 
 #define DO_IO(func, fd, buf, nbyte)					\
 	({												\
-		ssize_t ret = 0, r;							\
+		size_t done = 0;							\
+		ssize_t r;									\
 		do {										\
-			r = func(fd, buf + ret, nbyte - ret);	\
-			if (r < 0 && errno != EINTR) {			\
-				ret = -1;							\
+			r = func(fd, (char *)(buf) + done,		\
+				 (nbyte) - done);					\
+			if (r < 0) {							\
+				if (errno == EINTR)					\
+					continue;						\
+				done = (size_t)-1;					\
 				break;								\
 			}										\
-			else if (r > 0)							\
-				ret += r;							\
-		} while (r != 0 && (size_t)ret < nbyte);	\
+			done += (size_t)r;						\
+		} while (r != 0 && done < (size_t)(nbyte));	\
 													\
-		ret;										\
+		(ssize_t)done;								\
 	})
 
 #define RPMB_MULTI_CMD_MAX_CMDS 3

---
base-commit: c6692d5f9bf1ab6fbf5694a0b61477621cc4d016
change-id: 20261008-do-io-unsigned-counter-568a63baef5c

Best regards,
-- 
Sebastien Bacher <sebastien.bacher@canonical.com>


