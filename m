From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/3] arm/tegra: Move EN_VDD_1V05_GPIO to board-harmony.h
Date: Thu, 22 Sep 2011 09:11:40 +0100
Message-ID: <20110922081140.GH17169@n2100.arm.linux.org.uk>
References: <1316633620-13184-1-git-send-email-swarren@nvidia.com> <CAOesGMisOtEQpcS-hHi-3brpYzJr-UiB6b71c+bwkesPDk9iuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMisOtEQpcS-hHi-3brpYzJr-UiB6b71c+bwkesPDk9iuA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 21, 2011 at 01:16:49PM -0700, Olof Johansson wrote:
> Works for me. Or I could stage it in a topic branch that would be
> merged after Russell's GPIO tree.

Holding stuff off from being merged doesn't work.  If you have the
following commit structure:

A---...-----M1-B-C-M2
+---A1-B1-C1'     /
+-A2-B2-C2-------'

Now, lets say A2 depends on C1.  Merely delaying the stuff so that M2
happens after M1 is insufficient to ensure git state doesn't break.
When bisecting, its entirely possible that the bisect algorithm may
chose B2 as a potential test candidate.  At that point you end up with
A2, but without C1.

The only way to solve this is to have A2 following on from C1 - which
of course requires A1..C1 to be declared stable and either pulled into
your local tree or for A2..C2 to be submitted to the same tree which
A1..C1 are already in.
