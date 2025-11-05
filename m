Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C42749D3
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2025 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373830; cv=none; b=DYfwSYxFHJ/XDrGtLBimfVAvJpK+0fXUM7UcTZo0OQP5suWgeHLacllFe3B7aJ1W37j5MfWWbYwRQXnMb0dPbBlLrOmcT5wTIxWHxUlFT9Kq7Vkep2YM/PfUDSet+IsDduWsHFK3ar4jHmwIp/++o6f3bv7CbpugOw07Cq95F4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373830; c=relaxed/simple;
	bh=/zSiGYXUdz5m220NwXrpeeoWaqGx5RV0qTnq7vJe6Ek=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Cvzoz8ZWsOa0FACOJtPEnhncXGb61axIMUuNUt6fuVBbHqN7/mJKgsq++gMdV9GS58prPG9yMuzlxwlHyqKcVSao/pzMlb3Kyg79W89FscCPQSkX+8D+/kt4Scxy1x6z3JGmWRytZVZaXQDiGh5XmEGp1t2VJgL35tzhPNW9uRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=NzViNj/E; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="NzViNj/E"
DKIM-Signature: a=rsa-sha256; b=NzViNj/EDeeqlNoJa8rQT0FPwzKuYRpT12dwYdcuk2q/E2NGAQBH7ATo7HYJQUjwrl/PbwmVtNY+h2cUFeMSTQVdFO+kw4FzyoTQPMZa8x8e4/il8sAXU8hz+nAxRRcWlNHEvfa6VzgHKLOH3gZFzSrS8xJuHkdNwRR5pEAbhvbc6t8hmybwDVRT3IaQp0pHFEjYse5AnU6w8Xh6f8/PZjDlgjMYZUX4kZ0dAQASY+ElvAf+13/wBwFr3+YSxsL+1jQublPnvSQhJ8opRUYckpf4tDuflR+/SFnSlvrCrX1A5hTBout9no06rw2U2f6bADDApGJjio0anlbI7snaKg==; s=purelymail2; d=purelymail.com; v=1; bh=/zSiGYXUdz5m220NwXrpeeoWaqGx5RV0qTnq7vJe6Ek=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: linux-mmc@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1441939938;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 05 Nov 2025 20:16:50 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peter@korsgaard.com>)
	id 1vGjw1-005Xqa-06;
	Wed, 05 Nov 2025 21:16:49 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,  "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>,  Avri Altman <avri.altman@wdc.com>,  Ulf
 Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc-utils: lsmmc.c: print_mmc_cid(): correct
 year/month parsing
References: <20251104200008.940057-1-peter@korsgaard.com>
	<af77b269-a9e3-470b-a6bf-81636235bf5e@rock-chips.com>
	<87qzud6jq8.fsf@dell.be.48ers.dk>
	<77ce48fa-dfdf-43c9-8094-c1c47ff48aac@rock-chips.com>
	<PH7PR16MB619676787C5B72C51598EFEBE5C5A@PH7PR16MB6196.namprd16.prod.outlook.com>
Date: Wed, 05 Nov 2025 21:16:48 +0100
In-Reply-To: <PH7PR16MB619676787C5B72C51598EFEBE5C5A@PH7PR16MB6196.namprd16.prod.outlook.com>
	(Avri Altman's message of "Wed, 5 Nov 2025 19:57:58 +0000")
Message-ID: <87jz046xqn.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>>>>> "Avri" =3D=3D Avri Altman <Avri.Altman@sandisk.com> writes:

Hi,

 > Yeah - they noticed that as well and proposed a similar approach by
 > extending the ext-csd-rev to 9.0. I had the code ready for a while
 > now but somehow failed to submit it yet. Here it is.

Ahh, great!

> Thanks for fixing the year-month misplacement.

 > Thanks,
 > Avri


 > From c0e5ec1d3670161444943c8984b6cdafb82fac67 Mon Sep 17 00:00:00 2001
 > From: Avri Altman <avri.altman@sandisk.com>
 > Date: Thu, 13 Mar 2025 10:10:49 +0200
 > Subject: [PATCH] mmc: core: Adjust MDT beyond 2025
 > MIME-Version: 1.0
 > Content-Type: text/plain; charset=3DUTF-8
 > Content-Transfer-Encoding: 8bit

 > JEDEC JC64.1 proposal, which was recently approved, increases the
 > manufacturing year limit for eMMC devices. The eMMC manufacturing year
 > is stored in a 4-bit field in the CID register. Originally, it covered
 > 1997=E2=80=932012. Later, with EXT_CSD_REV=3D8, it was extended up to 20=
25. Now,
 > with EXT_CSD_REV=3D9, the range is rolled over by another 16 years, up to
 > 2038.

 > The mapping is as follows:

 > | cid[8..11] | ver =E2=89=A4 4 | rev > 4 | rev > 8 |
 > |------------|---------|---------|---------|
 > | 0          | 1997    | 2013    | 2029    |
 > | 1          | 1998    | 2014    | 2030    |
 > | 2          | 1999    | 2015    | 2031    |
 > | 3          | 2000    | 2016    | 2032    |
 > | 4          | 2001    | 2017    | 2033    |
 > | 5          | 2002    | 2018    | 2034    |
 > | 6          | 2003    | 2019    | 2035    |
 > | 7          | 2004    | 2020    | 2036    |
 > | 8          | 2005    | 2021    | 2037    |
 > | 9          | 2006    | 2022    | 2038    |
 > | 10         | 2007    | 2023    |         |
 > | 11         | 2008    | 2024    |         |
 > | 12         | 2009    | 2025    |         |
 > | 13         | 2010    |         | 2026    |
 > | 14         | 2011    |         | 2027    |
 > | 15         | 2012    |         | 2028    |

 > Signed-off-by: Avri Altman <avri.altman@sandisk.com>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

--=20
Bye, Peter Korsgaard
