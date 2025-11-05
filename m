Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384652C08BC
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2025 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325817; cv=none; b=DA9mjHatDyLWez3yn/MHqaXA+fjE+g57jiH5CfZcKQvL/DivLcFQK393mmDtGOhOhtnOW65/7U7aZcTwGtDEN9tcIBjtg9Lfmb/MSz9QxPD9JeSo1T6QzV8YlS2CcOYO60uXdhSs5SaVKVJV4doI4jJZB4Z9R4icD1dTzIJ6I80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325817; c=relaxed/simple;
	bh=b5SzSc+Yz0Fw+XDf/SRg7ZK5W4Txr+JRkL2uqtS+lGs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OPVRVzh3T81oUT7sZ03JQuwVuZTkZ1ZN/e824mVLtjdiiHc3HyzvAvZYMQTwC1ThN28xhwyXWWt/P7C4Vtyol5oNLiQV6NyTJJ3N8mk6btj0FCw2ReoNbemQFzugcmvzmuLMC4Z4P4EWC9Z5V6CiKnyqdZA8sgpAtQuEaQQFbSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ITEqw+Bv; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ITEqw+Bv"
DKIM-Signature: a=rsa-sha256; b=ITEqw+BvDnHHqo96kZ8NRxmHQsplxcP64EHm2szGKScQ67SqXCS4Ygq4JmKWtGC47nQsCnDpYI1S9xP4zcsaH5rda5Ks5jyVut6lPfK3Ftj0autCVLsn5WsgEF402jb3gRwUgh3Yx0p9bPjoQoTQZvzsMzbdWxIPF62JWseJST6VO+zl++ulLFx5fSXDyt9wnOzSu7IXop4OtCFGp2CsjBqJHgNXhyM4iN6D5k/ljHsDncSI3OAs9RrwdGOVKPCCE5hdOGsUClwYSPqtE/Fql0/P/fOLvtmyAzz+Q7gdH23ko+jNxvtWPmpMQxSB4w8nYzxO+OTqxE+IKFnpJlXEpw==; s=purelymail2; d=purelymail.com; v=1; bh=b5SzSc+Yz0Fw+XDf/SRg7ZK5W4Txr+JRkL2uqtS+lGs=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: linux-mmc@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1333216442;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 05 Nov 2025 06:56:45 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peter@korsgaard.com>)
	id 1vGXRj-004ePL-28;
	Wed, 05 Nov 2025 07:56:43 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org,  Avri Altman <avri.altman@wdc.com>,  Ulf
 Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc-utils: lsmmc.c: print_mmc_cid(): correct
 year/month parsing
References: <20251104200008.940057-1-peter@korsgaard.com>
	<af77b269-a9e3-470b-a6bf-81636235bf5e@rock-chips.com>
Date: Wed, 05 Nov 2025 07:56:43 +0100
In-Reply-To: <af77b269-a9e3-470b-a6bf-81636235bf5e@rock-chips.com> (Shawn
	Lin's message of "Wed, 5 Nov 2025 10:04:12 +0800")
Message-ID: <87v7jp6k7o.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>>>>> "Shawn" =3D=3D Shawn Lin <shawn.lin@rock-chips.com> writes:

 > =E5=9C=A8 2025/11/05 =E6=98=9F=E6=9C=9F=E4=B8=89 4:00, Peter Korsgaard =
=E5=86=99=E9=81=93:
 >> The parsing logic for the MMC manufacturing date had the year and month
 >> swapped.  From JESD84:
 >> The manufacturing date, MDT, is composed of two hexadecimal digits,
 >> four
 >> bits each, representing a two digits date code m/y; The =E2=80=9Cm=E2=
=80=9D field, most
 >> significant nibble, is the month code.  1 =3D January.  The =E2=80=9Cy=
=E2=80=9D field, least
 >> significant nibble, is the year code.
 >> Notice that this is the opposite of the SD bit ordering.
 >>=20

 > That's ture.

 > Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

 > Another problem I noticed when reading the code is:

 >  628                 printf("\tMDT: 0x%01x%01x %u %s\n", mdt_month,
 >  mdt_year,
 >  629                        1997 + mdt_year, months[mdt_month]);
 >  630                 printf("\tCRC: 0x%02x\n", crc);

 > From the JESD84-B51, section 7.2.7,

 > For e=E2=80=A2MMC 4.41 and later devices, indicated by a value larger th=
an 4 in
 > EXT_CSD_REV [192], the 4-bit=E2=80=9Cy=E2=80=9D field shall roll over af=
ter 2012, so
 > that y=3D0 shall be used for 2013. See Table 77 for a list of valid y
 > values for specific e=E2=80=A2MMC versions.

 > So mdt_year + 1997 seems wrong, too.

Yes, I noticed that as well. The print_mmc_cid() function does not
directly have access to the EXT_CSD_REV register though, so not trivial
to fix - Unless we read it at startup and stick it in the config
structure?

--=20
Bye, Peter Korsgaard
