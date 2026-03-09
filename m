Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1633E9F70
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076308; cv=none; b=DAWKuYx9Dy97q99+nkxfRZ2zxf4ADd3h8YXzELx5BjB9Wz1Xj0HpH3HD5mRTqWwEA+pFNb65d027R/RT72VOcD55rBl/rcPdYZG+TZTYjfO3Xbh7pYOp7msWFZYDSKKc7XyirvaO6ppQAhIcXa80/5VfpFvJUlYcELQDd3QqM0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076308; c=relaxed/simple;
	bh=4y9qa7ShObcaVrNIIZl3stBXIG4uu/dN07MTYjKlOrA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E0zu27Qt0yoR2GMX82U1+ZQvko3dPcbIrb+289nCAfvp8Xu5bIUFbZnDi6Vhvt++4waeEhkRqVUOcKcEA9Tn6l80a8SXBOH2hxCiOOT0Sslt21DU76NVwL4LGRhKaRziMKvnu/EW0wG39dIYVFIKNpFeT7yCkPSmQxIH/3J7YbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f6+lTgHd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f6+lTgHd"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id 79B3B20B6F00; Mon,  9 Mar 2026 10:11:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79B3B20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773076307;
	bh=4y9qa7ShObcaVrNIIZl3stBXIG4uu/dN07MTYjKlOrA=;
	h=Date:From:To:Subject:From;
	b=f6+lTgHdtRtCN1Xb5reJaZP9FyQiqxd+J1YWvpVwU131WWilyCaL66kWdTWMkS2wH
	 u3CC5QJ1Np2UUapakKO87ZPTm74I5NDbSbdAQpHV3KEKbPBSRbF2eGdOQ96eXiUWjU
	 /eeZtI7VTpnXctoqmbi8FJ6vzpmH7xsY2DC0e4ug=
Date: Mon, 9 Mar 2026 10:11:47 -0700
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: linux-mmc@vger.kernel.org
Subject: unsubscribe
Message-ID: <aa7/U/byyMCe9rbZ@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

unsubscribe linux-mmc
