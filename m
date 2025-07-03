Received: from mail-m49206.qiye.163.com (mail-m49206.qiye.163.com [45.254.49.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7486F19CCEC;
	Thu,  3 Jul 2025 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751513268; cv=none; b=I+LArVsKZ/YnWyIfmOxg6DkMEjXvNU0xUJ2ofxkW2pp4HfMFsWaG/fIoqUBee6l2bfErVqquvti3hYjsniXOBgjZS+MsCJT6RXjQLTX4O80FX+mxydCpT8BzJRmTK2YHI6rYdPkKM8yNKqWD7pPCQ2ojsyIsuidAiF3VsjOL2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751513268; c=relaxed/simple;
	bh=KsopXRsSq8U9zHjMO/KyzV/M+NUI8PEMCAH0YWr1kEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bw5Jhjw3mTQwR/5mxOj3+VcSQ8ce3RIeAzK3j6Z2ajqt5mG3nt3DDbGTleOabVTtwfSoxIWoqL3DpntR5vIq6iIopES86WBU8R4CWno0cGLEENs48cgi0EzszYSuzvfnwY+JVRbrDW3fcm+MxnwlNgPk88dPHuJlXvb1KulKFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=YWn7+1BV; arc=none smtp.client-ip=45.254.49.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="YWn7+1BV"
Received: from localhost.localdomain (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1abfaae27;
	Thu, 3 Jul 2025 11:27:40 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
Date: Thu,  3 Jul 2025 11:27:40 +0800
Message-Id: <20250703032740.4028222-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702142321.GA1462423-robh@kernel.org>
References: <20250702142321.GA1462423-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0IYVkNJSB4eGhgYHxpNTVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSk
	tLVUpCS0tZBg++
X-HM-Tid: 0a97ce5362b309cckunmadf8a94f538109
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQg6Fhw*PjE1CkwxShkTCxYB
	EDMKCxpVSlVKTE5KTkpISU1KQ0pCVTMWGhIXVQIaFRwBE0tCS007DxMOFR8eCQgUHQ9VGBQWRVlX
	WRILWUFZSkpMVUpDT1VKSUJVSkhPWVdZCAFZQUpLS0k3Bg++
DKIM-Signature:a=rsa-sha256;
	b=YWn7+1BVN1XOe5/NtsY7f9DbOQdJlxG5CzfVjEsxbQsDhoBz596hiEBA+kYr3atqXEBbRdpvqfjqoptaJU6mcgeurfzE6C/JQRbkmU8nPOb86vXcHjsEZ3F6lw9DsNRiBK8eG+TpXxBfrilrpTrQGR02M4zk+46e5brcHgyBi/Q=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=h+KkhhyoNcM7dhyZxw0qKxf+djo9dN4r5PuI4QZrL2Q=;
	h=date:mime-version:subject:message-id:from;

Hi Rob,

Thank you for the feedback.

> items:
>   - description: Core SDHCI registers
>   - description: CRM registers

Fixed. I've updated the reg property to use the items list format as suggested.

> Examples should be enabled. Drop.

Fixed. I've removed the `status = "disabled";` line from the example.

Best regards,
Albert Yang
