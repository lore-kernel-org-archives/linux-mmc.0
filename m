Received: from list.virtualsheetmusic.com (list.virtualsheetmusic.com [170.249.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671B59B7F
	for <linux-mmc@vger.kernel.org>; Thu,  4 Apr 2024 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.249.201.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215839; cv=none; b=ogQKhqy89XzO7cFciUx+89ZtV4+6lfhnag03fHwURNjAOmB2SVRyEdUBUvgjGN/snotonMmcI0dYQVBR9cJlYTrDWbOs2cCnSdmi7BNcNNiRBR3zBUpBEbX3yhpjWgQAcSM00krXCudjMkB+xZHPE6bOGJ/0aUOMe3a3uRBsvTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215839; c=relaxed/simple;
	bh=Kh6bFKp0zEzS8mXW8gXj5U1UJpOLExVceJOeJ13xwK0=;
	h=To:Subject:MIME-Version:From:Content-Type:Message-Id:Date; b=N0jnW2QEhB4EsNmes71IHboGlsdZx0euLAi/LnFADduTK3rcnZYhd3Y49XY+rKXXjX68eLTICdICxPKun1MlSPeGZb7hSDO+kxkcSl+aXBPSxRUmG8x+CUtZwtPPd1pL9J86yKA1+YrvLLbI9AtnHHNcWa5TsHxO793//GheSeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=musicianspage.com; spf=pass smtp.mailfrom=musicianspage.com; dkim=pass (1024-bit key) header.d=list.virtualsheetmusic.com header.i=@list.virtualsheetmusic.com header.b=lPKJcYnm; arc=none smtp.client-ip=170.249.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=musicianspage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=musicianspage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=list.virtualsheetmusic.com header.i=@list.virtualsheetmusic.com header.b="lPKJcYnm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=list.virtualsheetmusic.com; s=y; h=Date:Message-Id:
	Content-Transfer-Encoding:Content-Type:Reply-To:From:MIME-Version:Subject:To:
	Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=Kh6bFKp0zEzS8mXW8gXj5U1UJpOLExVceJOeJ13xwK0=; b=lPKJcYnmHm57
	h3g6CQOAiB3a5Y/PU3sm3hzzM+8ts1TMZx6fmd9syDu2DeUWRSgx+EF85jG8xfOafPFJ849+VRPcw
	KHG/RdVTFD6QDICJ/nF4wNaHN6+i2+DhijbvPltkRbykXVsD9iSikuK/DAfOyupP1FhW+LZ+kl3yH
	+dFWY=;
Received: from root by list.virtualsheetmusic.com with local (Exim 4.92)
	(envelope-from <no-reply@musicianspage.com>)
	id 1rsH5q-0003J6-At
	for linux-mmc@vger.kernel.org; Thu, 04 Apr 2024 00:01:02 -0700
To: linux-mmc@vger.kernel.org
Subject: Your confirmation is needed.
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Musicians Page <mailingconfirm@musicianspage.com>
Reply-To: Musicians Page <mailingconfirm@musicianspage.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1rsH5q-0003J6-At@list.virtualsheetmusic.com>
Date: Thu, 04 Apr 2024 00:01:02 -0700

Dear Musician and Music Lover,

thank you for your interest in subscribing
to the Musicians Page Newsletter.
It will keep you informed about the latest
information about music events, site updates
and news from the music industry.

Your subscription is NOT complete until we
receive your confirmation. To do so, just click
the link below which will confirm your registration:

https://www.musicianspage.com/cj.php?email=3Dlinux-mmc@vger.kernel.org


Remember that our staff is always available to answer your questions
or help with any problems. For assistance, just send a message to:
mailto:support@musicianspage.com.

We always strive to help you in your musical pursuits.

If you did not request, or do not wish to subscribe to the Musicians
Newsletter, please accept our apology and ignore this message.

Thank you very much for your attention.

My kindest regards,

Fabrizio Ferrari

supervisor
Musicians Page
https://www.musicianspage.com



