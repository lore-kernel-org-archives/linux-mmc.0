Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794684384;
	b=L+ony/fsXPFJc134qKXwOdsca8lYwZiileeOefE0DS3/AXl6SheLVKb87EyOlSgGek+G
	 Ua1sA5rH9gXgwYLelD3kNureAUHEPiNIPvuYEgTDvWyXpmCUuPdaq5risr3GagA/vXF+Z
	 Tf/EKM6XhC5dVPUwNe750Mer6X9ZQP7/jeyfY4qHjRpPJG+aZmW9S+R70jDQb61+XoVlD
	 Cyh9pEIZJCPjYGZoaNW4tjhfqYQ/HXzfFKN8JOrVvqo2rjNhM7yHGiYbFBW/uRf9r57Ot
	 B/zwlobc1KOQR4iqIU4u8QTCjdiRPx9yi1ng86oUy6nT6fHJ7kWS/mOds/6qxrFEpOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794684384;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:X-Mailer:References:
	 In-Reply-To:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=5D8dH6481qbs9B1RILO/vtXlXaJfRFQehlq7stzSvvI=;
	b=sovVFop5y4m6h5LJl2iipqB9CLOXcgYtq+0XgBs1IkY5/0qaPrFPUNXaW/lDnkgZou8r
	 6hajqPr2ID6F4+/aSBKe+j2zG3RJcIlBPPToyKIaj+xeRSCBA1l+npfTx3HQ3e7GVaQap
	 vWqaNtzg+lZTimluEUr5VoFkLjDse0cPEvCYg3WN2fdbhWOkiIvNqvxYkNz2/PSbciInV
	 aLSJk2gw2InB+sRwmwLbjJoomTFQ71aLrCpuOQd1JuY6puCeDO8TOr+fzHYFnYcpBQMgG
	 kDrsqhYbqlICuTJqlXrWSqLCiTJKdzSh7yLWpiaeLgP3OylUEr6oR4+mh5Ka4vflPjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=pjjonas@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ofOeppku;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4E606A330
	for <linux-mmc@vger.kernel.org>; Sat, 14 Nov 2026 19:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DD4E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=pjjonas@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ofOeppku
DKIM2-Signature:  i=1; m=1; t=1794684381;
 mf=PHBqam9uYXNAd2ViLmRlPg==;
 rt=PGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:tbkv4Q9E3BVdkVIzDFidEEWeeHRk
   Q+jUGFKkxDnAFvlq5lWkJoAHYlC/TnF4yckd7CdWdONSmJZWPIHbm/WPAqZfFQeo0b3eKKkCelb
   TDYcKuA+fx9O2B5/rUe7u+ZDWhNBVGg1oHH5nBSWxqa0+XKGMNDjlkPbx6wY8SDe9lPzgBMrfrG
   0KbxmsYOEzHBEklKKsShpXjtSqdsIIe3pLNTTfXos8eMRuPwxR5SavmjDHM0KNRrD1KiZv4zlUe
   ZYcJGrsLjuUdQOy86WsHxuX+Nl6h58DZcgDNmRVzDbbnsULAOSqyTvRDtTdOmuyqPza2C4v8OSD
   +teWKk6t5BlpXQ==;
Message-Instance:  m=1;
 h=sha256:
   vSfAUqK5ObTPiTp449vpzJXJHJ94KDNrNzvqRfJei+Y=:
   e4Wy5SWLe7g/4xjAwJ1/jnSGBYkDKDq5bQns3uVNbYE=,
  sha512:
   DKv7kGFynPid/d8x5OuWeFY2uh7alWGM+PbJltIqA2QxNepCW0CLirQ4cakHc+YskCIsEo9rtGt1XPf3Hn0Qxw==:
   S6+nX3fs9OwC6k3Txj0IwcVz+/3dhiHdEqjvR+uAsXXG2J27PfQrloaL9TxuOUr5EJ3FOVvEwEr5pd++yeYH9A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794684359; x=1795289159; i=pjjonas@web.de;
	bh=5D8dH6481qbs9B1RILO/vtXlXaJfRFQehlq7stzSvvI=;
	h=X-UI-Sender-Class:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=ofOeppkujXYo1pWzyedOqiFuMo8A96NSSoiay30oQvmzMvnt6z3ezlM1j64xlAiy
	 uLsIK1qHa2NfSPyucN1MtsvE0nRjmU5QVREzPXXd+qtqbEFU/5OlAJ9XEZ1UcjKoM
	 aDTIGBlHabaU4Yg/UHZOg9DWFuDd1i8FP99ZaSgD2ColjA8CUeabMdMjHnOPbHDlz
	 3/0f0aNxH/KQPln0sMp8lBXiRLSeVJuYY0j74SLA47ucRAb4lb97iu76yRbjob98M
	 ZW8aEPrgB/Ak/T8HFMvtKM4s87aX2e/uiFkztjhMDy0cxCQzJVf5bEN6pRgWkVDLm
	 5EuDI4O6Ar0N1e4eTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ek-1whNC50kvm-00mZOL; Sat, 14
 Nov 2026 20:25:59 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 20:25:56 +0100
Message-Id: <DMV6IBKUMJZE.3OQHO9YPDV854@web.de>
To: "Thorsten Leemhuis" <regressions@leemhuis.info>, "Philipp"
 <pjjonas@web.de>, <linux-mmc@vger.kernel.org>
Cc: <regressions@lists.linux.dev>, <ulf.hansson@linaro.org>
Subject: Re: [REGRESSION] rtsx_usb_sdmmc: RTS5129 (0bda:0129) no longer
 detects SD card
From: "Philipp Jonas" <pjjonas@web.de>
X-Mailer: aerc 0.22.0
References: <523eb7d1cc0811df4a5e4c534538f3dd@web.de>
 <eb52777b-8607-427b-a709-cf1ab76ef672@leemhuis.info>
In-Reply-To: <eb52777b-8607-427b-a709-cf1ab76ef672@leemhuis.info>
X-Provags-ID: V03:K1:hosvuYiul0EenUZ4BtRw+e6FZEXBW8+skVMVKOSjYBl3cOod1HS
 M7TcmP3Ns3BM00+qpO9M4tjewv3NLAtwjqu3GqQxjQUJ2f1+hMutrvAF0xe++/f5SZfAY0A
 JcS8CAqlgKSHkbwqa8PkUfZf5rOej8z6Gvkbsz95IMBQ+ZkGnmQ2ykh0ndprq22M50dMH2v
 WIXCl/J0vQzPIgOeAxMKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YcvVo7VYFn4=;pVxU+6If2njF53vQ6Rt0rsYvmn1
 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

On Wed Nov 11, 2026 at 10:06 AM CET, Thorsten Leemhuis wrote:
> On 11/8/26 19:51, Philipp wrote:
>>=20
>> the SD card in the internal Realtek RTS5129 USB card reader
>> (0bda:0129) of my Lenovo V110-15IKB is no longer detected.
>>=20
>> Works:  6.12.116, 7.2.x
>> Broken: 6.18.x, 7.3.3
>>=20
>> On broken kernels rtsx_usb and rtsx_usb_sdmmc load and the platform
>> devices rtsx_usb_sdmmc.0.auto / rtsx_usb_ms.1.auto exist, but no
>> mmc host/card appears (no mmc0, no mmcblk0) and there are no errors
>> in dmesg. Reloading rtsx_usb / rtsx_usb_sdmmc, re-inserting the card
>> and disabling USB autosuspend (power/control=3Don) do not help.
>>=20
>> Since 7.2.x worked but 6.18.x does not, I suspect a change that was
>> backported to stable.
>
> Might, but might not -- and I wonder if you have two bugs, some race, or
> if some .config setting is disturbing something. Overall this situations
> is somewhat puzzling. The best way to bring some light into this is afaic=
s:
>
> Check if 7.2 is working; if it is, bisect between that and 7.3.3; of
> not, bisect between 7.2 and 7.2.x to find what fixes things. And ensure
> to use the same .config as a base during the bisection, as explained here=
:
> https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.ht=
ml
>
> dmesg outputs from a working and a not-that-different version that is
> broken (say 7.2 and 7.3.3) would be helpful, too.
>
> Ciao, Thorsten

Thanks Thorsten, will do. I'll check 7.2 first and report back
with dmesg outputs and, if needed, bisection results. This may
take a few days, as kernel builds take a while here.

Philipp
