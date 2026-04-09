Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0419534B194
	for <linux-mmc@vger.kernel.org>; Thu,  9 Apr 2026 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729614; cv=none; b=iQNCVmrsp4NBaq6mDfLL1TfJ0NfVN1WJ54sOQtLtDE9Zi0xQYsPeTaAcPPgt0CHFjoFMneoz589TlPVEMrWyxPsZ/mrjSiomZDXYQayHQtjomNGUWc96+yUGzJMcCvSECgDFoAn6BAnBhD33XPq7BkSvNhbVBZrcPPZ5Z+/J82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729614; c=relaxed/simple;
	bh=XSReWibU4/SeW+tgoH+nnF7ubkE74AtdlhTbebdj/pU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MivdWy0+4i0abp7laEKpeOvQk9296Tg3r1JHp4Yg2o01kM4wTYWdfOWyav946hDnr6amPOKUoCElHuyQwdmoqW/U5+dXp0WKuWfn0r/1v4npcxxm0t5OBDTZMsj8/tyoTNVdnBhLGDkk0WN0rET5otbHIyLxE/VhSEOBFktfipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=i5ZZyK3d; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="i5ZZyK3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1775729596; x=1775988796;
	bh=XSReWibU4/SeW+tgoH+nnF7ubkE74AtdlhTbebdj/pU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=i5ZZyK3dX1Ijv5Chazbv0q3QlZxpsCpcbn5UZlJX2NuuvFTgUjGVWCDE56o+MHnxk
	 wqduAnEhHW+MCamm3dEwVvna72PLTjX0TAIfCqYCMUYafc2jb7zT0fegHpA21/DSvP
	 hOeHarejCD4R+6KDNn3OwJyrijzRIs5w1SibODxpWNLAqeLRA0Yc5OpIZrZ4Nv+Hkz
	 vMmcl3WA2vG9mMpvcX8UW/2CooIAcmmJ0Vph1rXnH+FXoVQup8iFr2Rx+m5IcOiFLN
	 mEGEmwjnwGKFzfuh4980FQgPCoh9+2d3yi6cucG26WfbkYzMwo1SvdJAM0cGzqWEVY
	 TolZ+sJK/qJ5Q==
Date: Thu, 09 Apr 2026 10:13:12 +0000
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Notes on using dd to clone Debian 13.4.0 KDE Plasma installation on my Edxis Chromebook model LI9
Message-ID: <tfcJ0dgWfa_aVegkJ4Et4mzX0ma1NUVjeuQfLBTMZcVDLXnp_sgZtnSiOCJ9_JJlxqvxnGQjl-BNnf8-8n3l0NpZ3_X9OgbVaDxMPXkzsKo=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 0f486fe5da709a012802f19dee1420fb8e0eaa2e
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Notes on using dd to clone Debian 13.4.0 KDE Plasma installation o=
n my Edxis Chromebook model LI9

Good day from Singapore,

Detailed steps as shown below.

1. Prepare USB thumb drive with System Rescue 13.00 for amd64. This is a 1.=
22 GB ISO file download.

2. Boot up Edxis Chromebook or your laptop or your desktop computer or your=
 server with System Rescue 13.00 USB thumb drive.

3. Connect a portable USB external harddisk to the Edxis Chromebook using a=
 USB 3.0 Hub.

4. Use the following Linux commands:

# mkdir /backup

Assuming your portable USB external harddisk is /dev/sdb1

# mount /dev/sdb1 /backup

# dd if=3D/dev/mmcblk0 bs=3D4M status=3Dprogress | gzip -1 > /backup/emmc.i=
mg.gz

=F0=9F=94=8D Explanation

bs=3D4M =E2=86=92 good speed for eMMC
status=3Dprogress =E2=86=92 shows progress
conv=3Dfsync =E2=86=92 ensures proper flushing (safer image)
gzip -1 =E2=86=92 fast compression (important for you)

=F0=9F=91=89 -1 is key:

Much faster than default (-6)
Slightly larger file, but saves a lot of time

The filesize of my emmc.img.gz is 4.71 GB.

The cloning process using dd took 916.149 seconds, which is about 15 minute=
s.

Taking about 15 minutes to clone Debian 13.4.0 KDE Plasma installation on E=
dxis Chromebook is relatively fast.

Restoring from the backup image file
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

# gunzip -c emmc.img.gz | dd of=3D/dev/mmcblk0 bs=3D4M status=3Dprogress co=
nv=3Dfsync

Once dd finishes:

# sync

Then reboot:

# reboot

=F0=9F=94=8D What this does

gunzip -c emmc.img.gz =E2=86=92 decompress image to stdout
| =E2=86=92 pipe into dd
dd of=3D/dev/mmcblk0 =E2=86=92 writes directly to your eMMC
bs=3D4M =E2=86=92 good performance
status=3Dprogress =E2=86=92 shows progress
conv=3Dfsync =E2=86=92 ensures all data is flushed to disk (important on re=
store)

I don't think I will be using Acronis True Image, Clonezilla, Rescuezilla, =
or fsarchiver any more since using dd is very fast. About 15 minutes only. =
And it resulted in only 1 backup image file which is what I have always wan=
ted.
1 backup image file is easier to manage.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Extremely Democratic People's Republic of Singapore
9 Apr 2026 Thursday 5.29 pm Singapore Time



