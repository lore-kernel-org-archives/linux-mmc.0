Received: from mail-m3275.qiye.163.com (mail-m3275.qiye.163.com [220.197.32.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584113191B5;
	Wed, 15 Oct 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513428; cv=none; b=TSeWLsp8vk+wcOAQ7yGNhJCrIm1BMw79tISQqltINkDNUWllraTmSG8RNqUm5HcqHXeAZWfaef+3IJ3qKkXcnQvde/IBlfLLyL0SQA72IoWL/of9mrstTrLQJDQT96NAF+H6ZP+cKdwZ0brCUEOx1uvs+0Do9bTvDE6ri7PtUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513428; c=relaxed/simple;
	bh=A4qtzS6/f/pecX6GOgrxPGmVThQldDEiFI2T/BUxuSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnzBps1/k9BhZ4o2xH5SyvERd/egQXKolyeIqxfQzQ4lE5cXx6OCO5+8nJY18we0Bg/eAGBy2AxFmuVsMJnCuUATImBtEGJc7bj/YE5ncwK5CU0zeZ7klfxCfaaonNfjJtwEI84kb+zX2I2wEUnKBj5QlBk/XTg/mjD7sez4+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=DiCuGLGh; arc=none smtp.client-ip=220.197.32.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="DiCuGLGh"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25f9bc543;
	Wed, 15 Oct 2025 15:30:15 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: adrian.hunter@intel.com
Cc: arnd@arndb.de,
	bst-upstream@bstai.top,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gordon.ge@bst.ai,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	robh@kernel.org,
	soc@lists.linux.dev,
	ulf.hansson@linaro.org,
	will@kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH 9/9] MAINTAINERS: add Black Sesame Technologies (BST) ARM SoC support
Date: Wed, 15 Oct 2025 15:30:14 +0800
Message-ID: <20251015073014.1480709-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <57743880-aecb-4300-8386-44d962659921@intel.com>
References: <57743880-aecb-4300-8386-44d962659921@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99e6c6d7c409cckunme94767a761da4f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTktMVhpDQhgYHx5CGEkdTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSEJVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DiCuGLGhn/KPK3GPbkC95HwnBSfdDQSl6wzN48jMYxr4NlDlx1h9TIsyGVqFQu2B6KU5LMb9zWxnuLHsbplmLMloHqzMwPEd43MCvj4YahW/3hpskaFGzLGtta3VEDTY6M1oiDNILtzKjdmVbj1stKUwOG5hChS++4BUT2mfbj0=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=O1qaZkX1700g4dn1D/gzvs0pnDtTldETwvN+nCYzCHU=;
	h=date:mime-version:subject:message-id:from;

Hi Adrian,

Thank you for the review and feedback!

On Mon, Sep 29, 2025 at 04:29:25PM +0300, Adrian Hunter wrote:
> On 23/09/2025 09:10, Albert Yang wrote:

> > +ARM/BST SOC SUPPORT
> > +M: Ge Gordon <gordon.ge@bst.ai>
> > +R: BST Linux Kernel Upstream Group <bst-upstream@bstai.top>
> > +L: linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S: Maintained
>
> Seems like it is "Supported" rather than "Maintained" ?
>
>         S: *Status*, one of the following:
>            Supported:   Someone is actually paid to look after this.
>            Maintained:  Someone actually looks after it.
>            Odd Fixes:   It has a maintainer but they don't have time to do
>                         much other than throw the odd patch in. See below..
>            Orphan:      No current maintainer [but maybe you could take the
>                         role as you write your new code].
>            Obsolete:    Old code. Something tagged obsolete generally means
>                         it has been replaced by a better system and you
>                         should be using that.> The status should likely be "Supported" rather than "Maintained"
> based on the MAINTAINERS guidelines.

You're absolutely right. "Supported" is more appropriate for this
vendor-supported hardware. I will update the STATUS field to
"Supported" in next of the patch series.

Thanks for pointing this out.

Best regards,
Albert Yang
