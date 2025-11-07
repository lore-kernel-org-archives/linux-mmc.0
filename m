Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4F23A564
	for <linux-mmc@vger.kernel.org>; Fri,  7 Nov 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525029; cv=none; b=pcj7i7nf/ElnsExqhgc/oVRcg72Nyll+35HkCsDhrO51FO7dQo9ormLYTIV5WrIvtQDbhg0UvlN6EF14BJm8HA2Jcp3F/hU7ATntHLMbGlkmmwEnPPuO1n1CeASW9CZUh6K/aPpeBEBqyhJkbQwSqSosR7apa343yfHjh4hyuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525029; c=relaxed/simple;
	bh=ZDojvFpwkc86Vneggax/ZOVs6WBS1eA7tZfZEwxALkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bepyu1C3XrL0mNWC28JSvBZdJeo4vfBCSU65zvrCzFjYW9Kc0ALVYKtNJwmFV927lG8tw299e82ZrlugcNVuGwFRci78LQBoEVR/S2jJwdC9BLCYG3nK/FKFdrrhsfKF1Rw35YUroZVAu5y53U/VoNK+GSJT1EN850Qkmi2gnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aSFVdkpm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aSFVdkpm"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c19b5de4so630595f8f.3
        for <linux-mmc@vger.kernel.org>; Fri, 07 Nov 2025 06:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762525023; x=1763129823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzsi+dNp+T2knF7qr9XbCjPuamEIJ82dLXer8FWdVBk=;
        b=aSFVdkpm7QvfbNXYT6eViUVAlkqSBEJZlsWDJxJ/sA2ussZRBv7Si+KPjRABRiAZ18
         vdZntKcx8kSJ+KwPBIWyJ6z7W+jsfrLj8aU19sj4uxuRLv+f+MTM9vdlh1Dzieud35XZ
         grnvYr4JHPItt7jk9qLxTkOgMUuI4KmDk/r/oOQingPJmN0WreRYXlyToxXDi6btGMMJ
         KDfDkZwkDkl/2HHGxVKLCP2/zDTm8bXLaLM9szLQqvs0UmdwITc07SlEyAOUM3ngN/zs
         TDBmAP3vnuOuHR13TSnjk2DcK5K9yjGCIVlSYiBMr6lZ4cDSHBC99i4Nr0kkL9hucjl3
         jC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525023; x=1763129823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzsi+dNp+T2knF7qr9XbCjPuamEIJ82dLXer8FWdVBk=;
        b=Wek5UQfu2O+2MbdvCk+xPitwuoa0H2GFAcN7aqlb6PGsqNA8483BueN91FPWseMYP6
         h/OY7srsXlwXVR4MV91LomvTwDuJOSeVKU+9Mkg15MBvrVdfBFyzhdcxZWjqEmegK2E4
         6uoRC3D9iIh20AvLUj5wi5aCzJWfHpZD4I37QZOvhXC15Y1MBdkQNBwxAJQp4iiiaHUl
         Y0xG0x6aj1iqvn8eITrfZYQImV5pxbPNcVZ2W5oJ3pFiw3TFwHKOhZqFyrlDdLt9xTfu
         fjXt9GKZ4oDAZGQvvyfbv1gHikxwUJsPYAfQyT62bW1W/RalchTiu5HsZxv7t1GVqhl0
         Mnkg==
X-Forwarded-Encrypted: i=1; AJvYcCVPNlWX+QyAp6c2Re1xl5YgFAKOKmpIWV28nGJwqg6ObbeiJZq4OemNiCaBNsnplieNEsTi/xQK8P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJXi5NLbBzytskzs37ai8/JT1YVxxbw8Ka1VdTBpOalxWXkrg7
	zd1fi1RA5AVdmqyp/MeGzIIV3vRjL+EIgGzMQUEHtCcsBW+l1GqSblLLpYNOW8j7OAaJYNVgqM4
	hrxvc
X-Gm-Gg: ASbGncujy2uxCRVM6r2LwxzGnsOE4mifNKJvZ1UnETOb+k/OJyk+VxZHK5Pa0vRILnp
	HFcMZHOR3ICLw0wycz4Z3f3BSfI29R/t6F03mlitYgGCW4R4H85Ptfc+CkCO2xnhAM2PUC5SbQq
	eg1meFGoa1SRu3sG8R2VgKzEGVjvVtNMarcdvg9OXSVftJspuUmm1xFPKu4WG9CjuT0OuS190G8
	qot+w9ABF9tCARbTc6U7IvQhAQ2xNDEW64hv/iKI7hILtxPYeSdHNj1zj5qKRkVDhcCt8FXKzeB
	NOPeicXAlZK5KFiJmmaYTXYzCxVgLUc4kWXQD9yOR2Cv9LJUd1kXRXTqp+ojjkyIibqC4A2Xtfh
	YlpXTrHbM0vaBvpsyTTJIvEcjFrP+laz5CIHcYals3kPJOqgWGtEJaVokLZQq4ckgxgkKXHXEr3
	bC3Y95YGSdBusXf0+7T47plx83
X-Google-Smtp-Source: AGHT+IFH0LXgWeIJgtl+gQta4fjJfleBNDxC0sB4rnU1I/EiNKg4zTlVBSSwvX1AJqwzlKSKz64XVQ==
X-Received: by 2002:a05:6000:2dc9:b0:427:928:787f with SMTP id ffacd0b85a97d-42ae5888a46mr3117979f8f.21.1762525023274;
        Fri, 07 Nov 2025 06:17:03 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ab6a7ad67sm5989764f8f.0.2025.11.07.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:17:02 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:16:54 +0100
Message-ID: <20251107141654.226947-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/mmc/core/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index c0ffe0817fd4..6a651ddccf28 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -3275,7 +3275,8 @@ static int mmc_blk_probe(struct mmc_card *card)
 	mmc_fixup_device(card, mmc_blk_fixups);
 
 	card->complete_wq = alloc_workqueue("mmc_complete",
-					WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+					WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
+					0);
 	if (!card->complete_wq) {
 		pr_err("Failed to create mmc completion workqueue");
 		return -ENOMEM;
-- 
2.51.1

