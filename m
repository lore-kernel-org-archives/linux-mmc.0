Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43237340A47;
	Mon, 23 Mar 2026 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260859; cv=none; b=Nm0NewH6oXXlQurTbZST6GdmOCFZgKqRUKTimxEp7DFR8lMsWCTpeYBppcYxLrzZqLnsTByHai6Z414TTQPuoPBkSWX3aJih6A7OCiS7Ufmlzbypss+EkdsMPRy+nTx8TQI5A/H8NA+Q4u/caFWL8h69PK1QqUrVj1QyGBPXQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260859; c=relaxed/simple;
	bh=e5vbmcDWh9YMiKuDpXYpTVRZyAfCmXhtq8lqazTf1FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELaKFNM15gJfLNyeQAlc7RHQpC5TE/OkWjndPGy/l36iDyJxwfAp1sr63+7CTEFR5VmcJ5zdpKjdDdCv4Hkym7Kl+BQ1Ytzvxk7soAADS0GzodB71RE6jN4ntGArzlpyu1xe/ArqJU/UgZZcHn+srVT2qKTLJKTBGwTZcOL8CwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyaATdUz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyaATdUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774260858; x=1805796858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e5vbmcDWh9YMiKuDpXYpTVRZyAfCmXhtq8lqazTf1FA=;
  b=OyaATdUzcKFd50VOUlHjBZTCZXdNlzSwNdY2bQUrO1aQHA3WwN62m4XV
   VDb1KfIqKrs+iCilTpXt/zcnssvHCb6iVAklSTdGYwFZLug1jaTqYgJ4j
   O67nxyUonFWJb5KrBwIoYdjjkWI7gwNn6wo0J8irXS1rB6JTLDgg2Yu7W
   kaB0+P3KFsWekYjx4+DhbKmLRu4663lNQsz1drtxTvr/JpU3pF8LMHClI
   UyTQj1RLctpAX2PW+tA2+vyMT4XktGJ7+A4MUuEwYMq8ns3sizlSCFkCw
   gM+f7HZkBA0Qdz5oMjGrz7aVEW2lmecJulDaCFDYD9KAzlxYFo3w+kSZy
   w==;
X-CSE-ConnectionGUID: sk3smrzZT+CyO86XZzmYDw==
X-CSE-MsgGUID: s7llIW2vSe6cZLXT2UbDTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75161670"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75161670"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:14:18 -0700
X-CSE-ConnectionGUID: P6xz7XyDQBCN2wbD89hlTA==
X-CSE-MsgGUID: VfnaTXBdQViAbtiGONla4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="254458489"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:14:12 -0700
Date: Mon, 23 Mar 2026 12:14:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nelson Johnson <nzjfr547@gmail.com>
Cc: hansg@kernel.org, adrian.hunter@intel.com, ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
Message-ID: <acEScW4vpBvVgkXF@ashevche-desk.local>
References: <23a36448-9006-47c4-9709-615a889ebd95@kernel.org>
 <20260321152501.6162-1-nzjfr547@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321152501.6162-1-nzjfr547@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 21, 2026 at 10:25:01AM -0500, Nelson Johnson wrote:
> On Sat, Mar 21, 2026 at 12:17:42PM +0100, Hans de Goede wrote:
> > Can you try running:
> > ls -ld /sys/bus/pci/devices/0000:00:12.0/firmware_node
> > and if that exists do:
> > cat /sys/bus/pci/devices/0000:00:12.0/firmware_node/status
> > I wonder if the PCI "slot" does have a ACPI companion-node
> > and if that has a status attribute, and if yes to both what
> > the status attribute says.
> 
> Done. Results below, collected on Debian vanilla, Fedora Live
> without Secure Boot, and Fedora Live with Secure Boot enabled.
> The results are identical across all three.

A side note: Your email lost the In-reply-to and possibly other headers, so it
looks like a new email thread, however by subject it seems as a reply into the
previous discussion. Check if you have nothing wrong with your email setup.

-- 
With Best Regards,
Andy Shevchenko


