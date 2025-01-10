Received: from mail-m12762.qiye.163.com (mail-m12762.qiye.163.com [115.236.127.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14150207E00;
	Fri, 10 Jan 2025 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736496969; cv=none; b=GAhCP2TH7In9c3Xq78DR+G1nEBm273PSy5tkxndfWXnh577utBXvlMSR8dzr8UpyEWj40iJLIf+4MS9VXZinjlkNmskU6OBe93XIg69nxTDEU4mUPbWa9adK5HioQneIJm5EecRbhSxLGgNm005obuiDtzD4pw4Wr1dihhiGuQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736496969; c=relaxed/simple;
	bh=DGw9xAgzScUiguLDjnG7bYniyXMlyHF5DSnqEqzO+FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxCMFOqPPFVjbZQu7ulr6kDoenlgFS5lI/KcJvRxj9LoRp/WQTKpy5NVWd6qPP4Iyq0fQv0DM06IkHzWqS2oyrKq3KWYNyBCh3M9znUlj0Pb/29NSWRf+GqP3qhZlGBoHKxggAp2asZr2olXiV+dFYWNk454Ke7fu7sZxmyYUrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ac3gz2WA; arc=none smtp.client-ip=115.236.127.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ac3gz2WA"
Received: from [172.16.12.67] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 851fbfa0;
	Fri, 10 Jan 2025 16:00:38 +0800 (GMT+08:00)
Message-ID: <b4df8a73-58a2-4765-a9e4-3513cb2bc720@rock-chips.com>
Date: Fri, 10 Jan 2025 16:00:38 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/17] dt-bindings: mmc: rockchip-dw-mshc: Add rk3562
 compatible string
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-4-kever.yang@rock-chips.com>
 <13860713.uLZWGnKmhe@phil>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <13860713.uLZWGnKmhe@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pCS1YdThlPQxlPHR5DSBpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a944f3ac48a03afkunm851fbfa0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRQ6LTo*OTISOQ8oIhYhESo0
	LB9PCUtVSlVKTEhNT0JNS09LSU9PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSk5CNwY+
DKIM-Signature:a=rsa-sha256;
	b=ac3gz2WAq5OUJlbH0VXidvDlgJ29scrwRqUnnOQXeZRh/XMPCGCiBVj7R+Pfe75GTH5wKDH7hAZK7+JFEskSZ7z8gC55pv8cgvHUm8uto0wBQ/SSCj0iIU6fG2wbgW2yQgJWlEfjNZ1M+vxI48sw16vlhbx5GnQlk0BjE8n/ipc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=ePfcZ2p/T1m/EvSrH7frcAMuiJufoadhcrRBzNxT72g=;
	h=date:mime-version:subject:message-id:from;


On 2024/12/26 08:39, Heiko Stuebner wrote:
> Am Dienstag, 24. Dezember 2024, 10:49:06 CET schrieb Kever Yang:
>> Add RK3588 compatible string for SD interface.
> 	^ this still says rk3588
Sorry, will update in next version.

Thanks,
- Kever
>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>
>> Changes in v2: None
>>
>>   Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
>> index 06df1269f247..772f592291bf 100644
>> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
>> @@ -38,6 +38,7 @@ properties:
>>                 - rockchip,rk3328-dw-mshc
>>                 - rockchip,rk3368-dw-mshc
>>                 - rockchip,rk3399-dw-mshc
>> +              - rockchip,rk3562-dw-mshc
>>                 - rockchip,rk3568-dw-mshc
>>                 - rockchip,rk3588-dw-mshc
>>                 - rockchip,rv1108-dw-mshc
>>
>
>
>
>
