Received: from msa.smtpout.orange.fr (msa-216.smtpout.orange.fr [193.252.23.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE33919ABAF;
	Wed, 21 Aug 2024 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247216; cv=none; b=dCj2xJe937kg6Gw3TnNkxVne3nh370/yRHd34nNoTly0dOfXy/jlhSGIguffNvyWodKnPIVADhkxvAqJKb9M42ijXat2lJfXZ6GcZkT4W6OuflbA/gPV9WaoIgWIKXNhwwa7IlJj4ZrIBFXlOXqN6xL06IvH1Jvb3BVH3we0UCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247216; c=relaxed/simple;
	bh=bGhQMQoqy6xj9S5PtIbnidaE79AttQ5nPqV+aP81t6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwHMnOGZuibOfCxdVt/tYbgVi+V0FeVnDEzvaKPhDRPvRTtqY/67I8fqtiPX164RIa1CV5HKJiz3LfuDn27NHbuYpnICgE6z0m8kUShBNwqrVmtTyTeiOObcqWBPP1ElMYjj6Acis2k9PPqFjCer6FP56rgHqzRNIxGxETbC7bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tMIWd+Hr; arc=none smtp.client-ip=193.252.23.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tMIWd+Hr"
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id glJrs0PPp730VglJrsKzX3; Wed, 21 Aug 2024 15:24:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724246651;
	bh=+fKgP6jNj7KiFHV3HJYLl7HCZ95eoEhddiFK//VjAsY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=tMIWd+HrAVY0P09rCIAztJZGPhsUYNFfnuz2MGupwZlzpDNq4fL3Tk/+a7EzSYBrT
	 URKcT3EHKikjQMHTSmHJ62vJ2yZR9HJMi+LuNsVua/SqknGIqMcvZfA8j62VnwiBRY
	 Ixj46Ls+MkuuRyWzWC4uqxp0OiwcEoWeBwofPcgf6W4A2hjOoBM5icxsQwPZUNRqyp
	 VqU8OzgjorlSeFP6NVUNrsJ8vRi4sDv+qV72DM2EkQO9m4jdB7rvscs/hDplQ0lqxc
	 QWhYwJFuyJJK2AqP6iIrO+09xkgEwb1ghlFeiBgN94oPTE+ZfqP5/2hmAh00PkYaJi
	 wlqvOH1HftO5w==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 21 Aug 2024 15:24:11 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: core: Remove struct mmc_context_info
Date: Wed, 21 Aug 2024 15:24:06 +0200
Message-ID: <232106a8a6a374dee25feea9b94498361568c10b.1724246389.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'mmc_context_info' structure is unused.

It has been introduced in:

  - commit 2220eedfd7ae ("mmc: fix async request mechanism for sequential
    read scenarios")

in 2013-02 and its usages have been removed in:

  - commit 126b62700386 ("mmc: core: Remove code no longer needed after the
    switch to blk-mq")
  - commit 0fbfd1251830 ("mmc: block: Remove code no longer needed after
    the switch to blk-mq")

in 2017-12.

Now remove this unused structure.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested in drivers/mmc/ only
---
 include/linux/mmc/host.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 49470188fca7..545bddfd7e1f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -292,20 +292,6 @@ struct mmc_slot {
 	void *handler_priv;
 };
 
-/**
- * mmc_context_info - synchronization details for mmc context
- * @is_done_rcv		wake up reason was done request
- * @is_new_req		wake up reason was new request
- * @is_waiting_last_req	mmc context waiting for single running request
- * @wait		wait queue
- */
-struct mmc_context_info {
-	bool			is_done_rcv;
-	bool			is_new_req;
-	bool			is_waiting_last_req;
-	wait_queue_head_t	wait;
-};
-
 struct regulator;
 struct mmc_pwrseq;
 
-- 
2.46.0

