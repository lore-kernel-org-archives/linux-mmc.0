Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8E346E43;
	Fri, 27 Mar 2026 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608740; cv=none; b=XPaBC0ShCOQXppec+QI/Ap4dZtPaodfW41nSDWxg79Ie1lAVDjzUOSa2awXP/4Fw9NpH234ndEgftDoC+y/Vnt2vQwJvTI2tMR/v4wa8r/S0svv537y+XrPFQGig5VZmkMV/qHXv65ubggjtbLTSOGQx74kQvpeIYM4CZEKUC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608740; c=relaxed/simple;
	bh=+KChBI4V8Mrm7CXCNXBb0LrDl0L0itk5n+ednFkugR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkg1IYC5p8OCoKMmM8KI4uj6//Zf3Nj8Azed+zdblkFF3HPUxlKvd27isoxL9/ziAHo2TZDw+75tbJB9ESIQZy8fb50ValPLurUzSRq8/AdUcw9IjGLA2qwCnUDTBiUlgPVfNKa669VGq+nTa4f6V52qj6WQY9j/Qd8TqJv5pxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp77Smk/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp77Smk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DDAC19423;
	Fri, 27 Mar 2026 10:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608740;
	bh=+KChBI4V8Mrm7CXCNXBb0LrDl0L0itk5n+ednFkugR4=;
	h=From:To:Cc:Subject:Date:From;
	b=jp77Smk/5N5hoH0l+FUfE2bvi8Z2Vez7Ine3t5TDFPqzUtLHMjN5Zrd3HgIVjMNQm
	 d/FNHBKwb4Wotwj4sWDV18DylYuABX5SqG9IuzyuyxV7bvMYQgk5bpON4OgCRbKv/u
	 UvMpGH3MM7Wo1MIHcFTNT0OnjgZ7XXfoWuDWcxZVQSnvnrHgelNU4lnjQX4bQdDTcd
	 Mdj5MqPywaYc0fX0Q8CrcC1jiB+h2oTgdw4H9VAYBBBj7NWKjMPWp6vqS2JSEUjuwf
	 klsYh/rERjYcNhAG2YVwtcJrH3OBmFZCHxCtus5E/D+BzbMrgK/jsn+C5swWY8JFBa
	 fw1hkTkZL6YAw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w64na-00000005UzS-0z1M;
	Fri, 27 Mar 2026 11:52:18 +0100
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/4] mmc: vub300: fix NULL-deref and UAF on disconnect
Date: Fri, 27 Mar 2026 11:52:04 +0100
Message-ID: <20260327105208.1310739-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes lifetime issues that can lead to NULL pointer
dereferences and use-after-free.

Included are also two related cleanups.

Johan


Johan Hovold (4):
  mmc: vub300: fix NULL-deref on disconnect
  mmc: vub300: fix use-after-free on disconnect
  mmc: vub300: rename probe error labels
  mmc: vub300: clean up module init

 drivers/mmc/host/vub300.c | 70 +++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

-- 
2.52.0

