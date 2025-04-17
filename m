Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB24204F6F;
	Thu, 17 Apr 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917707; cv=none; b=QT5RgMpJmzLBzrR9iU3nyiCv6D3rXAx4hTkdbFidlPn2MtumS0OYvJM+10d9Y5xFPqHqYKHgDhe71fIXuQjoWgmfVq8otK0f6+/Nez+5ruW8ZfmIpKhmBIaclJfMX/lYYnvdbnFTpLHpqgZqk+3jBGoNKhDPxWGIDN7LZPwsO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917707; c=relaxed/simple;
	bh=+CJrjIh4/VkCR9Ybqlx3vcctOMBAaHCVFAGSaZdoljE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omU5z5A6OhizlvMiDbyn+rwuHTf32Hhsmh59BkCNuHy1K3HEjg9F0zIAq8oI0egYRFP0tsXywi8eM0BLwQgl+fp+FSFAri5Rb5BoyKMv7gokdGaC3b5KAL34F4OPmL1GGphq/ft1LEFOywm7opEogx7mHeyMWo4eDCjUcu8vsOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=j7BzJDCM; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="j7BzJDCM"
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 2DA271F92A;
	Thu, 17 Apr 2025 21:21:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744917703;
	bh=SmTfEmql7viKQprPI4sVhC3SKjpRUpkDnqbejsbLIq4=;
	h=Received:From:To:Subject;
	b=j7BzJDCMxWpkhLzVc+rQ0qe0zbtPv3utjuB7ZRYficnRyKbMkzdFhg4YqTuq67Iiq
	 DeDEFr1hTOkfDEzz/4oYC20/xUtPFtAPgPBuDx5k2bp1/ej9QFtbXzSkvYiuYVSbdW
	 5tvYdGat0vGvZpdSrjBmM07OBDYOLme77osH5oqnUtpAXlENetU3a+M3Gj0L4THxz6
	 wqDFbdc3tZ2GUmsiAGzG3ha66fvBtLkyeLtVEHXWE+F9Logb+wAud+KS16e+AYB6qM
	 +l4YiCGHIKRHhbq5ZW2ILVrzYR1v5Sp5/9uDKGOBDbYw5K03FAn76caDXwak2634TY
	 oEx8q8dI62t8Q==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id DA19A7F823; Thu, 17 Apr 2025 21:21:42 +0200 (CEST)
Date: Thu, 17 Apr 2025 21:21:42 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josua Mayer <josua@solid-run.com>, Moteen Shah <m-shah@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Hiago De Franco <hiagofranco@gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch
Message-ID: <aAFUxuhn_5RlbjdQ@gaggiata.pivistrello.it>
References: <20250417182652.3521104-1-jm@ti.com>
 <20250417182652.3521104-2-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417182652.3521104-2-jm@ti.com>

Hello Judith,

On Thu, Apr 17, 2025 at 01:26:51PM -0500, Judith Mendez wrote:
> The sdhci_start_signal_voltage_switch function sets
> V1P8_SIGNAL_ENA by default after switching to 1v8 signaling.
> V1P8_SIGNAL_ENA has a timing component where it determines
> whether to launch cmd/data on neg edge (half cycle timing)
> or pos edge (full cycle timing) of clock. V1P8_SIGNAL_ENA also
> has a voltage switch component where if there exists an internal
> LDO, for SD this bit is used to switch from 3.3V to 1.8V IO
> signal voltage.
> 
> The sequence is to switch to 1.8 IO voltage, set V1P8_SIGNAL_ENA,
> change bus width, then update HIGH_SPEED_ENA & UHS_MODE_SELECT.
> During bus width change is when eMMC failures are seen with
> Kingston eMMC and various types SD cards across Sitara K3 SoCs.
> 
> So, add a quirk to suppress V1P8_SIGNAL_ENA and do not enable by
> default for eMMC since it is anyways optional for this interface
> and parse DT property: ti,fails-without-test-cd to apply the quirk
> for SD cards.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> Suggested-by: Hiago De Franco <hiago.franco@toradex.com>

Fixes: ac5a41b472b4 ("Revert "mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch"")
Fixes: 941a7abd4666 ("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch")
Cc:stable@vger.kernel.org

