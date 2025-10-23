Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC8307AC6
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221852; cv=none; b=jnp3TfeQOflbb0cNODT3mphHGLgFEefk4Z3vAupsfPDf/frygikdRXOvPifYSSOhc6B5eDHa+igUUsoWJkLSwZPsy4YlSTRQCHAebi9mOezoxQPREopqlNkWK93Uagj25gtcs7Wx65PeEtHpzC2JEpO8F/0LbuXFLlBSBcD/R3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221852; c=relaxed/simple;
	bh=L9mKMLdO9ecZLnnTb3rf9vDnZa5Hpnlr0lpYglBohUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkN4slYAY8/n7oE40x4QmjOoTIZOTdncwniQigF4KhzFg95UnST2xx6mfGmU9vX8qXqELhzLzsM4jqqZY2VepO9npRrEr4EaJ+iCu5ub+7OlG4jOs4ms0KI8hphvmTKyfX+oDhAtxmLS4xwO2abAq6yFZUMmTTempYafcE3jy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TxiNeiuB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TxiNeiuB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47114a40161so7378695e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761221845; x=1761826645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFaK6NZGo+5ymm+luUg7lb2XRBY37/W/zcfA+CV0TIg=;
        b=TxiNeiuBsMjIBd7XafBrQREloLoW1u8pXhvS6dJaJ29cZgxVi1nYTG0IneDhmkKf2X
         yxzTWw0mxyrdF8q9p8hWVZvsN6sdQFFst8033eGrrBnioq9bbunvizht+xfYmMv8yjI4
         LWQ/SYBnvNNVq8+mCiC4HdL/ogoyLTf3SHUtxbea5H6apLARN8FFNOGXWgwz5whst7DG
         D+q1IPoYpg9s7yGpPE8bGdavGqa9ut4l7CUjNNkx8Puptvu/+jRyJVOg3bePgVtjcwYG
         lJaZ2ZHuay66fL+7Tc8BssAZH3uEBmY2uguhjSEdQQJYXp7plMZXUXBwg7uYAYy8fBVE
         PZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221845; x=1761826645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFaK6NZGo+5ymm+luUg7lb2XRBY37/W/zcfA+CV0TIg=;
        b=iZnaz86n8EueMFroeTFJPAm1EdW4Dw0V0YQonLI7wEgwpzooSYbGCkXMSerImZnacA
         pQIwEPZyH6V+zEGdEmHz8zNnGNLnaPdrfSw2bQSlc6hctE+ThTdoeEsjjO5qXEUIDHHg
         S1neP3FMmq+SutCH+8YIybqVhZqGpnoY5jftcpK6bBXf0XUp2eR3Mo35USTIfHMe7upx
         v2EQuVBMXVYsA70gBP9czILJEqmpWLhM26ktSkzanirXiDHFQI77r/rw8MQUg20ulpcL
         EUIBIZq0L/NT4DFnYP8NwmoumKv13tTfn3mnZtFsG9e5Z9VfASGEAe7jCVhwEhULCkf/
         5XMA==
X-Forwarded-Encrypted: i=1; AJvYcCWHa35Gv0oNC0ET0pRJvfRi/Ya+ZkN8IiyBvnktZbQ6PlDXQ3bytzpgeizvOncGrwVBJdkzmbREEpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTmxwsQvDsAr1l/u6grhfDhpnT7C5wBjtgNeYHsnFgVol0qRBs
	7NMqvQ2HehcUTk1MM7kINEB1e8CM504fd4GoEygK22xvCEheji+akgL+J+NrpOB17ZA=
X-Gm-Gg: ASbGncspRwLwg+FV5x7g+a6THvbqBM50jcd174CbgL6T11/26eItGTlCSTRczZ0f5R5
	y02gt9VBsoDGIB7oYT/CfXSD1KG6F5LLtDEwWlAHtDIRsYHdlRJQGDOYV6NUe3BbbA0o5MjfB8H
	LGMUneGvdofMuT9cl3Rn7A6mYKe77SeI1y1yVjfDIKNsOSZJRqXeiYjEzp0Dcx3TTmolRC4QNG2
	PI/hqZoWp9tw3yQZHXcwfRoWZ7/DcKsQnFcoMOsqoDO3YwXOZ7dJMPVy/pQHqD601poMHvIBev/
	Rq4m0W8GV45E7OAlAmo93sKaRw/q5Pv6JB9cwKLnfNjcq/Dx2+aGoeF5PHYPN8WXxisIY2ZqDb4
	ctr2ABXU54vk8gQ0Q1NfDwuAxibsnEE8zwvsrgFSOOZGCbgjbpTCBbgqIhH02/EdF0xNuD8tp
X-Google-Smtp-Source: AGHT+IE4yJGL4XD1Y008GBekdf0k/4ZgBeS/2HKOoU8UbmPIZ1qtosiAH1bXdFg2PJCJM3E73unoRQ==
X-Received: by 2002:a05:600c:5009:b0:46e:50ce:a353 with SMTP id 5b1f17b1804b1-471178788f0mr170316305e9.14.1761221845468;
        Thu, 23 Oct 2025 05:17:25 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f685sm96429725e9.2.2025.10.23.05.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:17:24 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:17:22 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Subject: Re: [PATCH V2 4/4] arm64: dts: qcom: sm8750-qrd: Add SDC2 node for
 sm8750 qrd board
Message-ID: <ekyi4yreec55m5huqnfm7vqo3kgqgquvcmw4budgzolx32mfiq@lodlzpic4bdr>
References: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
 <20251023112924.1073811-5-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023112924.1073811-5-sarthak.garg@oss.qualcomm.com>

On 25-10-23 16:59:24, Sarthak Garg wrote:
> Enable SD Card host controller for sm8750 qrd board.
> 
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
> ---

again, with the card detect gpio in here, looks good to me:

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
