Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B830F541
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221795; cv=none; b=fkf/7hG2D7D7wD299iYZJG5yltpkv5B9GzBN/3FE1WiHHUFBn1BV/gpEPly7rr9qMUopCR/+8fZ9zGlYFBh07qYXV/pjOldwhJN2Pxx2EAw/Vx3LQkh7VtfCllSXa52OM3zG/Cgbu+Y1RPNn69mnSFvwvOQ98AOp4uHBa09noKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221795; c=relaxed/simple;
	bh=63w4Oubk2b9HQpsZ7UfW3R8E4afh0HvTI9mB0GUsn0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkbAgNRY5N8DktZ2tppp7iaRH+lu7aq14oxRdtBjtr/3d9l6BFMVxMfdVGPT6s40cAajZ+aZVk4YSGrHfnSMQ/RHmDYUFLgUNhLXWrUbtCgNztv6ShzW8d3+ftlW3/sq62zmO/ofzGd0BvOx4tNXASsYU6+g71+jWPZ7SNVji7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cOXcVqZH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOXcVqZH"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475c696ab23so4267325e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 05:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761221790; x=1761826590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsMGC1kCHKoVmEzx/3J2+LZIPEEzI0s7H5COsJ+wzeA=;
        b=cOXcVqZHhzJPb/AikVkdp+qMVGJe9QiY31Nbinlo9vOlhEMPqgvU8MOmPvxbdGoxoy
         JvRwY/gYx7Dccd7bhyFm0r3eSlSBQdwrxcneWMaCiepgg3Qamt/4du1gzR145FSZvo6S
         1AjMllEwEa1KAIt1vaouxzWSc75MmDQYjy9ZqPEq2wiwY6zv9iWDfaS+RSTXSSoZ3xqx
         FvMF8jRGqt9Kdfhp9g2d8NWlLBQBu1F4xJtbvR+XKk34ndS9fz7fKMa6fhPhr6buUzHA
         zC75FbmiTvZnwbi881wcter8Ki/Fh5RuGMZ4fM668gjobQaMzpQOITGRDzoLaPVEUAm/
         StYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221790; x=1761826590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsMGC1kCHKoVmEzx/3J2+LZIPEEzI0s7H5COsJ+wzeA=;
        b=nUgFCN6VqKeKjJiT418k8Tz40BKdhuZdK/6yPBS8Ve5HYU6wkq0KHbyEnIIG5TBOIP
         Ocz03TWb0uGijuy7S0KUYz2U2cfnoKwO+zN8Vw6oj+VGz3CvdT/yZJA8Hpngks5Ddbt+
         7EQ+bNzbwH6kQ6W6/mLXgeebdCAxSD5dVdW2CUAfm5BkybNpeYBgQwuTOsgABWsduNPc
         VPcd0eU4GU2n4+nQZwhSp1KcJcPoJWE+iyqi1sW6b7HCQf9K4GOJdTDNEDfZEmiDg3ZJ
         iq/T7qkPzUANYrlMs8XrD/gK5dcIjxpdjuaS1p0SYOTTqKyZ7hOFsek3odBG7fWhvRen
         nYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9kMQNeDZ3wnDLzDaH7k/Jp33tgczJKeLTNHX11swHyFOeiF8sRbTW/qRM+BX+8Mf/VMUDOF/Zfno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2izjVW4lcgjM/z8ZcdhwnCw0u4p1LzkHKUtHLxromlC1wf1D
	YG5JqS3KVuShGBxoNEbSFpHPpYUFEw4GscwE7A+OSkYk8iJNsoPMXHNvnbBu3RWSdBx/T63PGHq
	ws9RH
X-Gm-Gg: ASbGncuAjhLN56LJH94H9uynyCLIj7Tqis/bR9myTaDWVN3b2bAMkia4vWoiuA3UKZY
	LTBbGIisqTx7GnWgjaGiI84gkpyXp8r5mGq2A763MQFKMUqSUWN3snbwgzBdbI4jDdUV0nTTrQD
	k09oHsl2GQxWft+IclMBV3/aCLPcfXeHUixrPNDhi2XyEHEiUvycflJezps+TpcbN+jSw1HH+Qv
	0mvtyA2msUzgWhasP5qZmW8toUm2hlAo3G16Nl1dYY57IUrHU/k7E/x9bA/tH5e8iLlHE93WVrJ
	GrEjZXLWRQhcKbob0Q83KPDsQeqM5X3Eb3FxkMnyj70xzWa+/o95XMCPb3+NN+WJHFRmGqTQB7H
	mj05hle2+c4CG3ZDyAqcfZO91lxNJpv8WVn4gHJu4UNT5oQTLI7IQ7Ns5Jbw91WIbqrjU8K07Ik
	8MQstLjJQ=
X-Google-Smtp-Source: AGHT+IHFjzVLSym4Q6bXgkW+gQE8VmDlbUGdEH4H/I7XmfcC+FQGVre5Ex5Mf79etOc4+NZ/f0kF/A==
X-Received: by 2002:a05:600d:8394:b0:471:1717:421 with SMTP id 5b1f17b1804b1-4711790c587mr119581255e9.19.1761221789853;
        Thu, 23 Oct 2025 05:16:29 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4378cbesm90781295e9.16.2025.10.23.05.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:16:27 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:16:25 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Subject: Re: [PATCH V2 3/4] arm64: dts: qcom: sm8750-mtp: Add SDC2 node for
 sm8750 mtp board
Message-ID: <h6cpk4z3q2h6ymy565dytbza5mbldruhctg36utzdwjrd6ohjq@5rslxi2tm4z4>
References: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
 <20251023112924.1073811-4-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023112924.1073811-4-sarthak.garg@oss.qualcomm.com>

On 25-10-23 16:59:23, Sarthak Garg wrote:
> Enable SD Card host controller for sm8750 mtp board.
> 
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>

with the card detect gpio added here ...

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
