Received: from list.virtualsheetmusic.com (list.virtualsheetmusic.com [170.249.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729C35C61D
	for <linux-mmc@vger.kernel.org>; Thu,  4 Apr 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.249.201.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217066; cv=none; b=Y6s10byRfgshtjdFmrzhrHfCcy7aLthIwU9FHh7hD+VvElT/++6fxYpPPfLex+blGl4oyeSWgAsyt9rmp5PdBr0B8vdJYZYodffvjCaDjff5WZyPrWMOxnclAQqV036THZgnsEuHMo2hFHXEdPfKlszjHiBl9Ek3JRM0UgeP620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217066; c=relaxed/simple;
	bh=aOOGdYfXz1IrjbLaH6tskIGPTvRasIQxz+fxJYBv3F0=;
	h=To:Subject:MIME-Version:From:Content-Type:Message-Id:Date; b=hLygmA5pPby+xcuKp3i13awyJxqP8JIf+TkWptPSpBrPM3w0zCGBB6IkxIA90vXVVNMfd0qDtqMyUzL+AptQSeVrI5KoB27wuRUygqdIywKS09Bab9rDVjYLqNOLUl0bOTs082RQ5T0+RAKPBAezNWskYHqwqALWSoukccntFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=musicianspage.com; spf=pass smtp.mailfrom=musicianspage.com; dkim=pass (1024-bit key) header.d=list.virtualsheetmusic.com header.i=@list.virtualsheetmusic.com header.b=pK3vUjI5; arc=none smtp.client-ip=170.249.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=musicianspage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=musicianspage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=list.virtualsheetmusic.com header.i=@list.virtualsheetmusic.com header.b="pK3vUjI5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=list.virtualsheetmusic.com; s=y; h=Date:Message-Id:
	Content-Transfer-Encoding:Content-Type:Reply-To:From:MIME-Version:Subject:To:
	Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=aOOGdYfXz1IrjbLaH6tskIGPTvRasIQxz+fxJYBv3F0=; b=pK3vUjI5mjCG
	z/JvGm4he8YAT1vPlTXhx7UkLKeXV+AvvpsbEIZfrZFk+isRYA26qWNEaKatfCtzNzaAuVO/s1Mhu
	bgjnXj4JI1NkyygNLYh74w+Fw1soGCDEMXle0xCaFyjUBpCw0g00Ipx9Jt/7VAINen9gaZjVAPDyO
	IAKVg=;
Received: from root by list.virtualsheetmusic.com with local (Exim 4.92)
	(envelope-from <no-reply@musicianspage.com>)
	id 1rsHsD-0004n1-B4
	for linux-mmc@vger.kernel.org; Thu, 04 Apr 2024 00:51:01 -0700
To: linux-mmc@vger.kernel.org
Subject: You subscribed successfully.
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
Message-Id: <E1rsHsD-0004n1-B4@list.virtualsheetmusic.com>
Date: Thu, 04 Apr 2024 00:51:01 -0700

Dear Musician and Music Lover,

you have successfully subscribed
to the Musicians Page Newsletter.
It will keep you informed about the latest
information about music events, site updates
and news from the music industry.

You can personalize your Newsletter at any time from the following link:

https://www.musicianspage.com/em.php?email=3Dlinux-mmc@vger.kernel.org


Remember that our staff is always available to answer your questions
or help with any problems. For assistance, just send a message to:
mailto:support@musicianspage.com.

We always strive to help you in your musical pursuits.

You can unsubscribe at any time by clicking the link below:

https://www.musicianspage.com/unsubscribe.php?email=3Dlinux-mmc@vger.kernel=
=2Eorg


Thank you very much for your interest.

My kindest regards,

Fabrizio Ferrari

supervisor
Musicians Page
https://www.musicianspage.com



