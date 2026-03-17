Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37432D063A;
	Tue, 17 Mar 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762872; cv=pass; b=CrKrjCnU0tTpwBsZe0fLebBF+VuePr4VvM9TOQnGhIdmDNgFkrQPQJ6dR/tNO0w6EQv/2FoiBbjYMycTK0M+StzNsVj/KEqh4teIWiY/yXsIbSCrDfkhn6ytrBXjyvrRXfotb7wMhtUrkAr1wk9N5iAN6it8Hc7bu7khPTlqkQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762872; c=relaxed/simple;
	bh=lfxNJqkAn5nedMvtm/Giy9zfFi5rpr8yqgrJXgmm9gI=;
	h=Message-ID:MIME-Version:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:Date; b=MeWmrsim65SkGuITwaStyBthG2JfUVn5HWw98sbTjdVCYFWoQZuzxO61xutT8PqTJk4lZy0h05dpu7f9daa08VX4s6a4Y1BbAtHOh653IvHjRrq7ei2MQ1X6pcxs7HiDttZloIp21HiQjpUs3Zha72NjtAgXofKDyjQi8wyfBek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=N8dktOgP; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="N8dktOgP"
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 50F17441501;
	Tue, 17 Mar 2026 15:54:21 +0000 (UTC)
Received: from de-fra-smtpout10.hostinger.io (trex-green-3.trex.outbound.svc.cluster.local [100.115.143.3])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1DC08443A5F;
	Tue, 17 Mar 2026 15:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773762860;
	b=b61weR3qTzwwdmqJyI94fqXX2G8Q7UoYujr5CpkJBQufmk3KQqjTsfXFuifqNlfVIMQUQ+
	Zb5GoIDH42Qwpef0RoXYAnnShqKPdwenXMpGlzAX8ARXrJRzRSU5pjvVdBRcc7HvPZP2GE
	PK9NJzf9ApB06R8cmrgD8L13uzvoO9kgfA8xM5yg80ONYZSshHlTeLGgkpOU6KPHVa8rjd
	WQBg5i331RRPtS8rCSjLZsUWOiEjKSoqOvZQCuCRSKHM2qzei8bZPP3VneXC4u4YKczc8Y
	+EUQHRGQBV9QgLNBJPznZS0Wrz+5OKcb1a9KyWMBlkas3WPvKrC+g0k3W0o/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773762860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ILl2TqrEu5S8QBVXKLjl+G/C6M4r2ZltpX0HMEpdMmw=;
	b=KFseWj9vQw7waI91d1jD4C9V9iWI5bmYcVjXZ295r/i50nke6nN6LzuZ/G5z9kEPsEuBrj
	1ZcwlF0afGaNEmvSA51Rhc4LhS77CGslrHBCroxrY6M7W+/5+BTVSPpByP8mWtguipXSbq
	4xzQms43J43/gYBvYZLhk34FTqTHopIdJYKuTZUJUKFCpfoezyA8w7LCLS+P29rOvaETjj
	qbmkReB8/a/HYBG70YWjZnbQH/tgYXfo4HQa+Oc40I+8m7m/QTkKiidIqfGnnYkxzLSpk2
	8ziFyfDXE+FteP2lUXepUK1iOQtpynZjwvAF7XDrg6G2KSkoq7RJzoS2NUX/jQ==
ARC-Authentication-Results: i=1;
	rspamd-78765f9847-k8fbv;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Interest-Macabre: 274221fb23ded875_1773762861123_1944666366
X-MC-Loop-Signature: 1773762861123:2501252353
X-MC-Ingress-Time: 1773762861122
Received: from de-fra-smtpout10.hostinger.io (de-fra-smtpout10.hostinger.io
 [148.222.55.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.143.3 (trex/7.1.5);
	Tue, 17 Mar 2026 15:54:21 +0000
Received: from [IPV6:2001:861:4450:d360:2a72:4a2c:81bf:d1d4] (unknown [IPv6:2001:861:4450:d360:2a72:4a2c:81bf:d1d4])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4fZxN64SDxz3wnK;
	Tue, 17 Mar 2026 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1773762855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILl2TqrEu5S8QBVXKLjl+G/C6M4r2ZltpX0HMEpdMmw=;
	b=N8dktOgPXQBd0S/4dO0a9yNoHQlVfXPSThfnDEr3FYupVmQVvM/Zt93eiVQJ5UkeJYlTL5
	lENELrdv6VKeJQmaGq2vElqTsdbH2ey+hEY9+z44cvuAvtXuHMts9k/mmDc7pcB9DQVCxb
	eot8EYj0oCPwOnYPGCdHQzDhfMMSaULjXyyzSyNyYL5q+4xNPj4Foo0Yaa98O6iZIT80V1
	n7fEUE+X2M4oGX0thn+ti8SrLsGjzsxh1fXd+w9IRWcGODEvH/ZR2DdEKG3IiM3VSKhsNp
	g+8xs4euZQQ3BXf0iWNJZ1ER9twA3ejKNtpeEYBJEpXBQnHFyUaXY/wHWzbMxg==
Message-ID: <5fbc6f34-06d3-4e11-b9f7-f091cbf7394a@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com,
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Anand Moon <linux.amoon@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v3 6/7] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yixun Lan <dlan@kernel.org>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
 <20260316-orangepi-sd-card-uhs-v3-6-aefd3b7832df@gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-6-aefd3b7832df@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Mar 2026 15:54:14 +0000 (UTC)
X-CM-Envelope: MS4xfJw5AHuHKESwjxDU42t1s3Ntdjj/zJ52wwsXYYlRQARrN6B9FMg779E6OU6fQazbRZ+bWLG5XaO3Ntlgvf2SLKo1l5gVtS3EevJM26Cv+2YK3TO24ScR dtkz91LSXVI8KMYrrxjikwy6zfHYux/zzoWXi9bYBz5vsPA2B/mZfV+CkUFV4pZBkjpCbxrmmfgAU5XMARsge99C+0XEBumIz3AE/9GjjsYz51Ovt8JBk5FW Iwe7hqbmOXuXU8L5leCOV4bHVgDvn77uwAkvVfXv4RdGdJ9GOJY4OKt12Ucf7Cmh0Xy+MN448nX/3DtQzh0x/weDvOn86VCaa3XBMSJo+XRGRJB+g8GpDyCq G+zZACs0al7qKDgrDbp6y6kmA0WTIUo8ZvOA66GGh71eUr3RnKE4YEAkJbQkq4aIT+kuSwOPS/T+BJ2+I3Wf98SshtNlTj6LWnzJkqiyKlU0W4JTH5Cm3IEh DbN5uLy8tnnkf3Dg0QOYdlJICLyecy5gfP9eXFYzAlqzS8mNshQAmfGaZBxmlcPqYS+JvukqtmO0BBEbA1jmBa/VeFfuzJS2XNKAwY5lu4NrPxjwI9zbwtyl UjHkq1vVbjHX9Fj3YDXUN6vJEhfha9dL6mjUegX8KHfcoPX7rAN0fq0/dG222h2xfE/4MmClBv2j6ztnssNTtvc6ZMzztxhjrHksMq90vY43szkM6N1Si09X XFM5E2SOE9a15HZm1nMVMj9cVfhhG9akQXRfd0cG7w/h8REGvYyvtYncLiogf0JKA6RWRgypgR21tIgd6EPFSxNdCBIvtMtpQRY3nvq3WrNiqAOFMNi85E1N Fo5BoX87N4fRKE8ePYmaW1ddfRAQHel5qVqDmcYQ2/VT+er3DATVkRakruHBMuwpT+jnVvA9IfUXyezepwfPFBGey+y5+jv2FqRK3tp0Zi+0S8My3EA1nM5x xVBscA==
X-CM-Analysis: v=2.4 cv=Ceda56rl c=1 sm=1 tr=0 ts=69b97927 a=eExTT1VkZWUTeek0JR7vTg==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=d70CFdQeAAAA:8 a=pGLkceISAAAA:8 a=IpJZQVW2AAAA:8 a=LzP2-JvhAYZmahfDZeMA:9 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22 a=IawgGOuG5U0WyFbmm1f5:22
X-AuthUser: michael.opdenacker@rootcommit.com

Hi Iker

Thanks for the update!

On 3/16/26 3:03 PM, Iker Pedrosa wrote:
> Add complete SD card controller support with UHS high-speed modes.
>
> - Enable sdhci0 controller with 4-bit bus width
> - Configure card detect GPIO with inversion
> - Connect vmmc-supply to buck4 for 3.3V card power
> - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
> - Add dual pinctrl states for voltage-dependent pin configuration
> - Support UHS-I SDR25, SDR50, and SDR104 modes
>
> This enables full SD card functionality including high-speed UHS modes
> for improved performance.
>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>   arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> index f1533c99881dbf38e16cff5e91e33253cfa7a56d..aff23846085d22d1e9cd77434bffd2816ad59e12 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> @@ -140,3 +140,22 @@ aldo1: aldo1 {
>   		};
>   	};
>   };
> +
> +&sdhci0 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc1_cfg>;
> +	pinctrl-1 = <&mmc1_uhs_cfg>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
> +	cd-inverted;
> +	no-mmc;
> +	no-sdio;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	vmmc-supply = <&buck4>;
> +	vqmmc-supply = <&aldo1>;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	status = "okay";
> +};


Tested successfully on OrangePi RV2.
Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Cheers
Michael

-- 
Root Commit
Embedded Linux Training and Consulting
https://rootcommit.com

